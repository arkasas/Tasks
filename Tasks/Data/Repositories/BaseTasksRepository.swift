import Foundation

class BaseTasksRepository: TasksRepository {
    enum BaseTaskErrors: Error {
        case unknow
    }
    private let dataTransferService: DataTransferService
    private let cache: TasksStorage

    init(dataTransferService: DataTransferService, cache: TasksStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }

    func fetchTasksList(query: TaskQuery,
                        completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
        let responsibility = TaskRepositoryQueue(dataTransferService: dataTransferService,
                                                 cache: cache)

        responsibility.execute(query: query) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        return responsibility
    }

    func updateTask(task: Task, completion: @escaping (Bool) -> Void) {
        cache.update(task: task) { result in
            completion(true)
        }
    }
    
    private class TaskRepositoryQueue: Cancellable {
        func cancel() {
        }
        
        private let taskGroup: DispatchGroup
        private let dataTransferService: DataTransferService
        private let cache: TasksStorage

        private var savedFavouriteTasks: [Task] = []
        private var downloadedTasks: Tasks?
        private var error: Error?
        
        init(dataTransferService: DataTransferService, cache: TasksStorage) {
            taskGroup = DispatchGroup()
            self.dataTransferService = dataTransferService
            self.cache = cache
        }
        
        func execute(query: TaskQuery,
                     completion: @escaping (Result<Tasks, Error>) -> Void) {
            executeMemoryTask()
            executeServiceTask(query: query)
            
            taskGroup.notify(queue: .main) { [unowned self] in
                if let error = self.error {
                    completion(.failure(error))
                } else if let tasks = self.downloadedTasks {
                    completion(.success(self.combineTasks(tasks: tasks)))
                } else {
                    completion(.failure(BaseTasksRepository.BaseTaskErrors.unknow))
                }
            }
        }
        
        private func combineTasks(tasks: Tasks) -> Tasks {
            var taskCopy = tasks
            for i in 0..<taskCopy.task.count where savedFavouriteTasks.contains(taskCopy.task[i]) {
                taskCopy.task[i].isFavourite = true
            }
            
            return taskCopy
        }
        
        private func executeMemoryTask() {
            taskGroup.enter()
            cache.fetch { result in
                if case let Result.success(tasks) = result {
                    self.savedFavouriteTasks = tasks
                }
                
                self.taskGroup.leave()
            }
        }
        
        private func executeServiceTask(query: TaskQuery) {
            taskGroup.enter()
            let requestDTO = TasksRequestDTO(query: query.query)
            let endpoint = APIEndpoints.getTask(with: requestDTO)
            dataTransferService.request(with: endpoint, completion: { result in
                switch result {
                case .success(let responseDTO):
                    self.downloadedTasks = responseDTO.toDomain()
                case .failure(let error):
                    self.error = error
                }
                
                self.taskGroup.leave()
            })
        }
    }
}
