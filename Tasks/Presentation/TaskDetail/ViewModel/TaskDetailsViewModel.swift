import Foundation

protocol TaskDetailViewModelInput {
}

protocol TaskDetailViewModelOutput {
    var title: String { get }
    var subtitle: String { get }
    var date: String { get }
    var info: String { get }
    var imageURL: URL { get }
}

protocol TaskDetailViewModel: TaskDetailViewModelInput, TaskDetailViewModelOutput { }

final class BaseTaskDetailViewModel: TaskDetailViewModel {
    var subtitle: String
    var date: String
    var info: String
    var title: String
    var imageURL: URL
    
    init(task: Task) {
        self.title = task.title
        self.subtitle = task.subtitle
        self.info = task.info
        self.date = task.addDate
        if let url = URL(string: task.image) {
            imageURL = url
        } else {
            imageURL = URL(string: "https://cdn.pixabay.com/photo/2017/04/09/12/45/error-2215702_1280.png")!
        }
    }
}
