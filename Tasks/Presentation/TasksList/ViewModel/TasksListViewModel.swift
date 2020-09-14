import Foundation

struct TasksListViewModelActions {
    let showTaskDetails: (Task) -> Void
}

protocol TasksListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol TasksListViewModelOutput {
    var items: Observable<[TasksListItemViewModel]> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

protocol TasksListViewModel: TasksListViewModelInput, TasksListViewModelOutput {}

class BaseTasksListViewModel: TasksListViewModel {
    var items: Observable<[TasksListItemViewModel]> = Observable([])
    var query: Observable<String> = Observable("")
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String { return "Tasks List" }
    var errorTitle: String = "Error"

    private let tasksUseCase: TasksUseCase
    private let actions: TasksListViewModelActions
    private var tasksLoadResponsibility: Cancellable? { willSet { tasksLoadResponsibility?.cancel() } }

    init(tasksUseCase: TasksUseCase,
         actions: TasksListViewModelActions) {
        self.tasksUseCase = tasksUseCase
        self.actions = actions
    }

    private func appendTasks(_ tasks: Tasks) {

    }

    private func load(query: TaskQuery) {
        self.query.value = query.query

        tasksLoadResponsibility = tasksUseCase.execute(
            requestValue: .init(query: query),
            cached: appendTasks,
            completion: { [weak self] result in
                switch result {
                case .success(let tasks):
                    self?.appendTasks(tasks)
                case .failure(let error):
                    self?.handle(error: error)
                }
        })
    }

    private func handle(error: Error) {
        self.error.value = "Failed loading movies"
    }

}

// MARK: Input
extension BaseTasksListViewModel {
    func viewDidLoad() {
        load(query: .init(query: query.value))
    }

    func didSelectItem(at index: Int) {

    }
}
