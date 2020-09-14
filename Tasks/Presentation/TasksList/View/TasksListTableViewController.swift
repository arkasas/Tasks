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
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
    }

    private func bind(to viewModel: TasksListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.reload()
        }
        viewModel.query.observe(on: self) { [weak self] in
            print($0)
        }
        viewModel.error.observe(on: self) { [weak self] in
            print($0)
        }
    }
}

// MARK: - Table view data source & delegate
extension TasksListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TaskTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(TaskTableViewCell.self) with reuseIdentifier: \(TaskTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath.row)
    }
}
