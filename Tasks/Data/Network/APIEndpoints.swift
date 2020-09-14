struct APIEndpoints {
    static func getTask(with requestDTO: TasksRequestDTO) -> Endpoint<TasksResponseDTO> {
        return Endpoint(path: "/560e0cbec4d423b0e916fa8ad3a06e17/raw/088e6cf732d46d3ebb288e08a3def3263ab23868/tasks.json",
                        method: .get,
                        queryParametersEncodable: requestDTO)
    }
}
