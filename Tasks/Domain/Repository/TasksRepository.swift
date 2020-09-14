protocol TasksRepository {
    @discardableResult
    func fetchTasksList(query: TaskQuery,
                        cached: @escaping (Tasks) -> Void,
                        completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable
}

