import Foundation

protocol TaskDetailViewModelInput {
}

protocol TaskDetailViewModelOutput {
    var title: String { get }
    var subtitle: String { get }
    var date: String { get }
    var info: String { get }
}

protocol TaskDetailViewModel: TaskDetailViewModelInput, TaskDetailViewModelOutput { }

final class BaseTaskDetailViewModel: TaskDetailViewModel {
    var subtitle: String
    var date: String
    var info: String
    var title: String
    
    init(task: Task) {
        self.title = task.title
        self.subtitle = task.subtitle
        self.info = task.info
        self.date = task.addDate
    }
}
