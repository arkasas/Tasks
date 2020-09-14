import Foundation

struct Task: Equatable {
    let id: Int
    let title: String
    let subtitle: String
    let info: String
    let addDate: String
    let status: Status

    enum Status {
        case done
        case inProgress
        case pending
    }
}

struct Tasks: Equatable {
    let task: [Task]
}

extension Task.Status {
    func toListViewModel() -> TasksListItemViewModel.Status {
        switch self {
        case .done:
            return .done
        case .inProgress:
            return .inProgress
        case .pending:
            return .pending
        }
    }
}
