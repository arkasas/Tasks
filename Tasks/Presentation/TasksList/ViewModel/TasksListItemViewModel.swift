struct TasksListItemViewModelActions {
    let reverseTaskFavourite: (Int, (Bool) -> Void) -> Void
}

protocol TasksListItemViewModelInput {
    func didSelectFavouriteItem()
}

protocol TasksListItemViewModelOutput {
    var id: Int { get }
    var title: String { get }
    var subtitle: String { get }
    var addDate: String { get }
}

protocol TasksListItemViewModel: TasksListItemViewModelInput, TasksListItemViewModelOutput {}

struct BaseTasksListItemViewModel: Equatable, TasksListItemViewModel {
    static func == (lhs: BaseTasksListItemViewModel, rhs: BaseTasksListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    enum Status {
        case done
        case inProgress
        case pending
    }

    let id: Int
    let title: String
    let subtitle: String
    let addDate: String
    let status: Status

    private let actions: TasksListItemViewModelActions
    init(actions: TasksListItemViewModelActions,
         task: Task) {
        self.actions = actions
        id = task.id
        title = task.title
        subtitle = task.subtitle
        addDate = task.addDate
        status = task.status.toListViewModel()
    }
}

// MARK: Input
extension BaseTasksListItemViewModel {

    func didSelectFavouriteItem() {
        actions.reverseTaskFavourite(id) {
            print($0)
        }
//        print(actions.reverseTaskFavourite(id))
    }
}
