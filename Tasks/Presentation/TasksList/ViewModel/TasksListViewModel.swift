import Foundation

struct TasksListViewModelActions {
    let showTaskDetails: (Task) -> Void
}

protocol TasksListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func didAddItemToFavourite(itemId: Int)
    func didRemoveItemFromFavourite(itemId: Int)
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
    private var tasks: Tasks?

    init(tasksUseCase: TasksUseCase,
         actions: TasksListViewModelActions) {
        self.tasksUseCase = tasksUseCase
        self.actions = actions
    }

    private func appendTasks(_ tasks: Tasks) {
        self.tasks = tasks

        items.value = tasks
            .task
            .map { BaseTasksListItemViewModel(
                actions: TasksListItemViewModelActions(reverseTaskFavourite: reverseTask),
                task: $0)
            }
    }

    private func load(query: TaskQuery) {
        self.query.value = query.query

        tasksLoadResponsibility = tasksUseCase.execute(
            requestValue: .init(query: query),
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

    private func reverseTask(_ taskId: Int, completion: (Bool) -> Void) {
        guard var task = tasks?.task.filter { $0.id == taskId }.first else {
            completion(false)
            return
        }

        task.isFavourite = !(task.isFavourite ?? false)
        tasksUseCase.updateStoredMemeory(task: task) { result in
            self.load(query: .init(query: self.query.value))
        }
    }
}

// MARK: Input
extension BaseTasksListViewModel {
    func viewDidLoad() {
        load(query: .init(query: query.value))
    }

    func didSelectItem(at index: Int) {
        guard let item = tasks?.task[index] else {
            return
        }
        actions.showTaskDetails(item)
    }

    func didAddItemToFavourite(itemId: Int) {
        print(itemId)
    }

    func didRemoveItemFromFavourite(itemId: Int) {
        print(itemId)
    }
}
