import UIKit

final class ApplicationDI {
    lazy var applicationConfigurator = ApplicationConfiguration()

    lazy var apiDataService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: "https://gist.githubusercontent.com/arkasas")!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    func createTasksSceneDI() -> TasksSceneDI {
        let dependencies = TasksSceneDI.Dependencies(apiDataTransferService: apiDataService)
        return TasksSceneDI(dependencies: dependencies)
    }
}
