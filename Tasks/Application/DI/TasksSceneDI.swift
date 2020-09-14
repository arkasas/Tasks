import UIKit

final class TasksSceneDI {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    private lazy var tasksResponseCache: TasksResponseStorage = CoreDataTasksResponseStorage()
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createTasksFlowCoordinator(navigationController: UINavigationController) -> TasksListCoordinator {
        return TasksListCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }

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

}

extension TasksSceneDI: TasksListCoordinatorDependencies {
}
