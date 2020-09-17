//
//  TaskDetailSceneTest.swift
//  TasksTests
//
//  Created by Arkadiusz Pituła on 17/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import XCTest

@testable import Tasks
class TaskDetailSceneTest: XCTestCase {

    func testViewModelCorrect() {
        let viewModel = BaseTaskDetailViewModel(task: Task.mockTask)
        let scene = TaskDetailViewController.create(with: viewModel)
        _ = scene.view

        XCTAssertNotNil(scene.dateLabel.text)
        XCTAssertNotNil(scene.infoLabel.text)
        XCTAssertNotNil(scene.subtitleLabel.text)
    }

}
