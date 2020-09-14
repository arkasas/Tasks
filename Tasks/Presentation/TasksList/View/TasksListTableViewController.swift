import UIKit

class TasksListTableViewController: UITableViewController, StoryboardInstantiable {

    static func create(with viewModel: TasksListViewModel) -> TasksListTableViewController {
        let view = TasksListTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    static var name: String {
        return "TasksList"
    }

    private var viewModel: TasksListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    private func setupViews() {
        title = viewModel.screenTitle
    }

    private func bind(to viewModel: TasksListViewModel) {
        viewModel.items.observe(on: self) { [weak self] in
            print($0)
        }
        viewModel.query.observe(on: self) { [weak self] in
            print($0)
        }
        viewModel.error.observe(on: self) { [weak self] in
            print($0)
        }
    }
}
