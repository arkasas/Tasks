//
//  TasksUseCaseTests.swift
//  TasksTests
//
//  Created by Arkadiusz Pituła on 16/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import XCTest

@testable import Tasks
class TasksUseCaseTests: XCTestCase {

    class MockCancellable: Cancellable {
        func cancel() {}
    }

    class TaskRepositoryMock: TasksRepository {
        var tasks: Tasks = Tasks(task: [])

        func fetchTasksList(query: TaskQuery, completion: @escaping (Result<Tasks, Error>) -> Void) -> Cancellable {
            completion(.success(tasks))
            return MockCancellable()
        }

        func updateTask(task: Task, completion: @escaping (Bool) -> Void) {
            completion(true)
        }
    }

    class DataTransferServiceMock: DataTransferService {
        func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T : Decodable, T == E.Response, E : ResponseRequestable {
            let task = TasksResponseDTO(tasks: [TasksResponseDTO.TaskDTO.mockTask])
            completion(.success(task as! T))
            return nil
        }

        func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where E : ResponseRequestable, E.Response == Void {
            return nil
        }
    }
    class TasksStorageMock: TasksStorage {
        func fetch(completion: @escaping (Result<[Task], Error>) -> Void) {
            completion(.success([
                Task(
                    id: 0,
                    title: "title",
                    subtitle: "subtitle",
                    info: "info",
                    addDate: "addDate",
                    status: .done,
                    isFavourite: true,
                    image: "image")
            ]))
        }

        func update(task: Task, completion: @escaping (Result<Bool, Error>) -> Void) {
            completion(.success(true))
        }

    }

    private let mockTask = Task(
        id: 0,
        title: "title",
        subtitle: "subtitle",
        info: "info",
        addDate: "addDate",
        status: .done,
        isFavourite: true,
        image: "image")

    func testGetTasksFromRepository() {
        let expectation = self.expectation(description: "Tasks getter")
        expectation.expectedFulfillmentCount = 2
        
        let useCase = BaseTasksUseCase(tasksRepository: TaskRepositoryMock())
        _ = useCase.execute(requestValue: TasksUseCaseRequestValue(query: TaskQuery(query: ""))) { result in
            if case Result.success = result {
                XCTAssert(true)
            } else {
                XCTFail("Something wrong. Could not get Tasks")
            }
            expectation.fulfill()
        }

        useCase.updateStoredMemeory(task: mockTask) { result in
            XCTAssert(result)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testBaseTaskRepository() {
        let expectation = self.expectation(description: "BaseTaskTest")

        let config = ApiDataNetworkConfig(baseURL: URL(string: "https://gist.githubusercontent.com/arkasas")!)
        let apiDataNetwork = DefaultNetworkService(config: config)

        let repository = BaseTasksRepository(dataTransferService: DataTransferServiceMock(),
                                             cache: TasksStorageMock())
        let result = repository.fetchTasksList(query: TaskQuery(query: "")) { result in
            if case let Result.success(value) = result, let favourite = value.task.first?.isFavourite {
                XCTAssert(favourite)
            } else {
                XCTFail("Expected that value of favourite will be true")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
}

extension Task {
    static var mockTask: Task {
        return Task(
            id: 0,
            title: "title",
            subtitle: "subtitle",
            info: "info",
            addDate: "addDate",
            status: .done,
            isFavourite: true,
            image: "image")
    }
}

extension TasksResponseDTO.TaskDTO {
    static var mockTask: TasksResponseDTO.TaskDTO {
        return TasksResponseDTO.TaskDTO(
            id: 0,
            title: "title",
            subtitle: "subtitle",
            info: "info",
            addDate: "addDate",
            image: "image",
            status: TasksResponseDTO.StatusDTO.done)
    }
}
