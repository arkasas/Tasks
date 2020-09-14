protocol TasksUseCase {
    func execute(requestValue: TasksUseCaseRequestValue,
                 cached: @escaping (Tasks) -> Void,
                 completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable
}

final class BaseTasksUseCase: TasksUseCase {

    private let tasksRepository: TasksRepository

    init(tasksRepository: TasksRepository) {
        self.tasksRepository = tasksRepository
    }

    func execute(requestValue: TasksUseCaseRequestValue,
                 cached: @escaping (Tasks) -> Void,
                 completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
        return tasksRepository.fetchTasksList(query: requestValue.query,
                                              cached: cached,
                                              completion: completion)
    }
}

struct TasksUseCaseRequestValue {
    let query: TaskQuery
}
