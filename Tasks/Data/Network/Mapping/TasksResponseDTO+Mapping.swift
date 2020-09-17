import Foundation

struct TasksResponseDTO: Decodable {
    struct TaskDTO: Decodable {
        let id: Int
        let title: String
        let subtitle: String
        let info: String
        let addDate: String
        let image: String
        let status: StatusDTO
    }

    enum StatusDTO: String, Decodable {
        case done
        case inProgress
        case pending
    }

    let tasks: [TaskDTO]
}

extension TasksResponseDTO {
    func toDomain() -> Tasks {
        return Tasks(task: tasks.map { $0.toDomain() })
    }
}

extension TasksResponseDTO.TaskDTO {
    func toDomain() -> Task {
        return Task(id: id,
                    title: title,
                    subtitle: subtitle,
                    info: info,
                    addDate: addDate,
                    status: status.toDomain(),
                    image: image)
    }
}

extension TasksResponseDTO.StatusDTO {
    func toDomain() -> Task.Status {
        switch self {
        case .pending:
            return .pending
        case .inProgress:
            return .inProgress
        case .done:
            return .done
        }
    }
}
