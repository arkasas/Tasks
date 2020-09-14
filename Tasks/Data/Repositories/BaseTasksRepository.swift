import Foundation

class BaseTasksRepository: TasksRepository {

    private let dataTransferService: DataTransferService
    private let cache: TasksResponseStorage

    init(dataTransferService: DataTransferService, cache: TasksResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }

    func fetchTasksList(query: TaskQuery,
                        cached: @escaping (Tasks) -> Void,
                        completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
        let requestDTO = TasksRequestDTO(query: query.query)
        let responsibility = RepositoryResponsibility()

        cache.getResponse(for: requestDTO) { [weak self] result in
            if case let .success(responseDTO) = result {
                cached(responseDTO.toDomain())
            }

            let endpoint = APIEndpoints.getTask(with: requestDTO)
            responsibility.networkTask = self?.dataTransferService.request(with: endpoint, completion: { result in
                switch result {
                case .success(let responseDTO):
                    self?.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }

        return responsibility
    }
}
