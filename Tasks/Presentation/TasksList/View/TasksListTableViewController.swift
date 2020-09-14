//
//  TasksListTableViewController.swift
//  Tasks
//
//  Created by Arkadiusz Pituła on 14/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import UIKit

class TasksListTableViewController: UITableViewController, StoryboardInstantiable {

    static func create(with viewModel: TasksListViewModel) -> TasksListTableViewController {
        let view = TasksListTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    private var viewModel: TasksListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
