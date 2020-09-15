import Foundation
import CoreData

protocol TasksStorage {
    func fetch(completion: @escaping (Result<[Task], Error>) -> Void)
    func update(task: Task, completion: @escaping (Result<Bool, Error>) -> Void)
}

extension Task {
    func toEntity(in context: NSManagedObjectContext) -> TaskResponseEntity {
        let entity: TaskResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.subtitle = subtitle
        entity.info = info
        entity.created = addDate
        entity.status = status.rawValue
        entity.favourite = isFavourite ?? true
        return entity
    }
}
