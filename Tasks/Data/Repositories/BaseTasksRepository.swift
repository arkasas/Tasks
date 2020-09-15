import Foundation

class BaseTasksRepository: TasksRepository {

    private let dataTransferService: DataTransferService
    private let cache: TasksStorage

    init(dataTransferService: DataTransferService, cache: TasksStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }

    func fetchTasksList(query: TaskQuery,
                        completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
        let requestDTO = TasksRequestDTO(query: query.query)
        let responsibility = RepositoryResponsibility()

        let endpoint = APIEndpoints.getTask(with: requestDTO)
        responsibility.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
        return responsibility
    }

    func updateTask(task: Task, completion: @escaping (Bool) -> Void) {
        cache.update(task: task) { result in
            completion(true)
        }
    }
}
