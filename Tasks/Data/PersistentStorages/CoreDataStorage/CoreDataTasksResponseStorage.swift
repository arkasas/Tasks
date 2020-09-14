import CoreData
import Foundation

final class CoreDataTasksResponseStorage {
    enum MockError: Error {
        case unknow
    }
}

extension CoreDataTasksResponseStorage: TasksResponseStorage {
    func getResponse(for request: TasksRequestDTO, completion: @escaping (Result<TasksResponseDTO, Error>) -> Void) {
        completion(.failure(CoreDataTasksResponseStorage.MockError.unknow))
    }

    func save(response: TasksResponseDTO, for requestDTO: TasksRequestDTO) {
        
    }
}
