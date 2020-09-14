import Foundation

struct Task: Equatable {
    let id: Int
    let title: String
    let description: String
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
