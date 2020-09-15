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
        if viewModel.isFavourite {
            addImageToFavouriteButton("baseline_star_black_48pt")
        } else {
            addImageToFavouriteButton("baseline_star_border_black_48pt")
        }
    }

    @IBAction private func didSelectFavourite() {
        viewModel.didSelectFavouriteItem()
    }
    
    private func addImageToFavouriteButton(_ imageName: String) {
        favouriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
