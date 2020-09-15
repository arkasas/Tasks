import UIKit

class TaskTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: TaskTableViewCell.self)

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var favouriteButton: UIButton!

    private var viewModel: TasksListItemViewModel!

    func fill(with viewModel: TasksListItemViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.addDate
    }

    @IBAction private func didSelectFavourite() {
        viewModel.didSelectFavouriteItem()
    }
}
