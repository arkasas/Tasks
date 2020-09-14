import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get }
    func start()
}

class ApplicationCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController?
    private let applicationDI: ApplicationDI

    init(navigationController: UINavigationController,
         applicationDI: ApplicationDI) {
        self.navigationController = navigationController
        self.applicationDI = applicationDI
    }

    func start() {
        guard let nvc = navigationController else {
            print("There is a problem with navigation controller")
            return
        }
        let tasksSceneDI = applicationDI.createTasksSceneDI()
        let flow = tasksSceneDI.createTasksFlowCoordinator(navigationController: nvc)
        flow.start()
    }
}
