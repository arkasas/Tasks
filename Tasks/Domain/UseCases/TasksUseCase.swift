protocol TasksUseCase {
    func execute(requestValue: TasksUseCaseRequestValue,
                 completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable

    func updateStoredMemeory(task: Task,
                             completion: @escaping (Bool) -> Void)
}

final class BaseTasksUseCase: TasksUseCase {

    private let tasksRepository: TasksRepository

    init(tasksRepository: TasksRepository) {
        self.tasksRepository = tasksRepository
    }

    func execute(requestValue: TasksUseCaseRequestValue,
                 completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
        return tasksRepository.fetchTasksList(query: requestValue.query,
                                              completion: completion)
    }

    func updateStoredMemeory(task: Task, completion: @escaping (Bool) -> Void) {
        tasksRepository.updateTask(task: task, completion: completion)
    }
}

struct TasksUseCaseRequestValue {
    let query: TaskQuery
}
