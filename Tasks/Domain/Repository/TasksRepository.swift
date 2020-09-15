protocol TasksRepository {
    @discardableResult
    func fetchTasksList(query: TaskQuery,
                        completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable

    func updateTask(task: Task, completion: @escaping (Bool) -> Void)
}

