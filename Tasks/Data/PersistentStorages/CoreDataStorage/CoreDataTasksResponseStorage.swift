import CoreData
import Foundation

final class CoreDataTasksResponseStorage {
    enum MockError: Error {
        case unknow
    }

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    private func fetchTasks() -> NSFetchRequest<TaskResponseEntity> {
        let request: NSFetchRequest = TaskResponseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "favourite == %@" ,
                                        NSNumber(booleanLiteral: true))
        return request
    }

    private func fetchAllTasks() -> NSFetchRequest<TaskResponseEntity> {
        let request: NSFetchRequest = TaskResponseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "favourite == %@" ,
                                        NSNumber(booleanLiteral: true))
        return request
    }

    private func deleteTask(_ task: Task, in context: NSManagedObjectContext) {
        let request = fetchAllTasks()
        do {
            let result = try context.fetch(request).filter({ $0.id == task.id })
            result.forEach { context.delete($0)}
        } catch {
            print(error)
        }
    }
}

extension CoreDataTasksResponseStorage: TasksStorage {
    func fetch(completion: @escaping (Result<[Task], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchTasks()
                let requestEntity = try context.fetch(fetchRequest)
                let model = requestEntity.map {
                    $0.toModel()
                }
                completion(.success(model))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func update(task: Task, completion: @escaping (Result<Bool, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteTask(task, in: context)
                self.saveTaskIfNeeded(task: task, context: context)
                try context.save()
                completion(.success(true))
            } catch {
                debugPrint("CoreDataTasksResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }

    private func saveTaskIfNeeded(task: Task, context: NSManagedObjectContext) {
        if task.isFavourite == true {
            _ = task.toEntity(in: context)
        }
    }
}
