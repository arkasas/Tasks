struct APIEndpoints {
    static func getTask(with requestDTO: TasksRequestDTO) -> Endpoint<TasksResponseDTO> {
        return Endpoint(path: "/b315fa8615546744e41079bec3eaedea/raw/b2835348a5b2a7a509e3ae06bde3eea1d9f45850/tasks.json",
                        method: .get,
                        queryParametersEncodable: requestDTO)
    }
}
