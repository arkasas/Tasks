//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Arkadiusz Pituła on 14/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController, StoryboardInstantiable {

    static func create(with viewModel: TaskDetailViewModel) -> TaskDetailViewController {
        let view = TaskDetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    static var name: String {
        return "TaskDetail"
    }

    @IBOutlet private(set) var subtitleLabel: UILabel!
    @IBOutlet private(set) var dateLabel: UILabel!
    @IBOutlet private(set) var infoLabel: UILabel!
    @IBOutlet private(set) var imageView: UIImageView!

    private var viewModel: TaskDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        title = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.date
        infoLabel.text = viewModel.info
        imageView.setImage(from: viewModel.imageURL)
    }
}
