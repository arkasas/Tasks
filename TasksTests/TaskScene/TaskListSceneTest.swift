//
//  TaskListSceneTest.swift
//  TasksTests
//
//  Created by Arkadiusz Pituła on 17/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import XCTest

@testable import Tasks
class TaskListSceneTest: XCTestCase {

    class SimpleCancel: Cancellable {
        func cancel() {

        }
    }

    class TaskUseCaseMock: TasksUseCase {
        func execute(requestValue: TasksUseCaseRequestValue, completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
            completion(.success(Tasks(task: [Task.mockTask])))
            return SimpleCancel()
        }

        func updateStoredMemeory(task: Task, completion: @escaping (Bool) -> Void) {
            completion(true)
        }
    }

    func testTaskListViewModel() {
        let viewModel = BaseTasksListViewModel(tasksUseCase: TaskUseCaseMock(),
                                               actions: TasksListViewModelActions(showTaskDetails: { _ in }))
        viewModel.viewDidLoad()
        XCTAssertEqual(viewModel.items.value.count, 1)
    }

}
