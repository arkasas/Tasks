struct TasksListItemViewModel: Equatable {
    enum Status {
        case done
        case inProgress
        case pending
    }

    let title: String
    let subtitle: String
    let addDate: String
    let status: Status
    
    init(task: Task) {
        title = task.title
        subtitle = task.subtitle
        addDate = task.addDate
        status = task.status.toListViewModel()
    }
}
