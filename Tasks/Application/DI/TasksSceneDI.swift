import UIKit

final class TasksSceneDI {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createTasksFlowCoordinator(navigationController: UINavigationController) -> TasksListCoordinator {
        return TasksListCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }

    func createTasksListViewController(actions: TasksListViewModelActions) -> TasksListTableViewController {
        return TasksListTableViewController.create(with: <#T##TasksListViewModel#>)
    }

    private func createTasksListViewModel(actions: TasksListViewModelActions) -> TasksListViewModel {
        return BaseTasksListViewModel(tasksUseCase: <#T##TasksUseCase#>,
                                      actions: actions)
    }

    private func createTasksUseCase() -> TasksUseCase {
        return BaseTasksUseCase(tasksRepository: <#T##TasksRepository#>
    }

    private func createTasksRepository() -> TasksRepository {
        return BaseTasksRepository(dataTransferService: dependencies.apiDataTransferService,
                                   cache: taskRes)
    }

}

extension TasksSceneDI: TasksListCoordinatorDependencies {
}
