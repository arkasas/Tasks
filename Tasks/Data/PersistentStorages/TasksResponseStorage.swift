import Foundation

protocol TasksResponseStorage {
    func getResponse(for request: TasksRequestDTO, completion: @escaping (Result<TasksResponseDTO, Error>) -> Void)
    func save(response: TasksResponseDTO, for requestDTO: TasksRequestDTO)
}
