import UIKit

protocol TasksListCoordinatorDependencies {
    func createTasksListViewController(actions: TasksListViewModelActions) -> TasksListTableViewController
}

class TasksListCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    private let dependencies: TasksListCoordinatorDependencies
    private weak var tasksListVC: TasksListTableViewController?

    init(navigationController: UINavigationController,
         dependencies: TasksListCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = TasksListViewModelActions(showTaskDetails: showTaskDetails)
        let vc = dependencies.createTasksListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
        tasksListVC = vc
    }

    private func showTaskDetails(_ task: Task) {

    }
}
