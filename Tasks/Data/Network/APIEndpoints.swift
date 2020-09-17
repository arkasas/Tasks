struct APIEndpoints {
    static func getTask(with requestDTO: TasksRequestDTO) -> Endpoint<TasksResponseDTO> {
        return Endpoint(path: "/f027fa417c29ee34a18d6bece4e530f1/raw/54d3514c92288502405702e20286b011b93324ad/tasks.json",
                        method: .get,
                        queryParametersEncodable: requestDTO)
    }
}
