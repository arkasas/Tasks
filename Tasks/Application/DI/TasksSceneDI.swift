import UIKit

final class TasksSceneDI {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    private lazy var tasksResponseCache: TasksStorage = CoreDataTasksResponseStorage()
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createTasksFlowCoordinator(navigationController: UINavigationController) -> TasksListCoordinator {
        return TasksListCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }

    // MARK: Task list
    func createTasksListViewController(actions: TasksListViewModelActions) -> TasksListTableViewController {
        return TasksListTableViewController.create(with: createTasksListViewModel(actions: actions))
    }
    
    private func createTasksListViewModel(actions: TasksListViewModelActions) -> TasksListViewModel {
        return BaseTasksListViewModel(tasksUseCase: createTasksUseCase(),
                                      actions: actions)
    }

    private func createTasksUseCase() -> TasksUseCase {
        return BaseTasksUseCase(tasksRepository: createTasksRepository())
    }

    private func createTasksRepository() -> TasksRepository {
        return BaseTasksRepository(dataTransferService: dependencies.apiDataTransferService,
                                   cache: tasksResponseCache)
    }
    
    // MARK: Task details
    func createTaskDetailViewController(task: Task) -> TaskDetailViewController {
        return TaskDetailViewController.create(with: createTaskDetailViewModel(task: task))
    }
    
    private func createTaskDetailViewModel(task: Task) -> TaskDetailViewModel {
        return BaseTaskDetailViewModel(task: task)
    }

}

extension TasksSceneDI: TasksListCoordinatorDependencies {
}
