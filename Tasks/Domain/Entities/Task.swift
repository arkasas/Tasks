import Foundation

struct Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let subtitle: String
    let info: String
    let addDate: String
    let status: Status
    var isFavourite: Bool?

    enum Status: String {
        case done
        case inProgress
        case pending

        init(value: String) {
            if value == Status.done.rawValue {
                self = .done
            } else if value == Status.inProgress.rawValue {
                self = .inProgress
            } else if value == Status.pending.rawValue {
                self = .pending
            } else {
                self = .pending
            }
        }
    }
}

struct Tasks: Equatable {
    var task: [Task]
}

extension Task.Status {
    func toListViewModel() -> BaseTasksListItemViewModel.Status {
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
