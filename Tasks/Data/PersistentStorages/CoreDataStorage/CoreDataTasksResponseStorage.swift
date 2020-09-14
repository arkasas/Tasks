import CoreData
import Foundation

final class CoreDataTasksResponseStorage {
    
}

extension CoreDataTasksResponseStorage: TasksResponseStorage {
    func getResponse(for request: TasksRequestDTO, completion: @escaping (Result<TasksResponseDTO, Error>) -> Void) {

    }

    func save(response: TasksResponseDTO, for requestDTO: TasksRequestDTO) {
        
    }
}
