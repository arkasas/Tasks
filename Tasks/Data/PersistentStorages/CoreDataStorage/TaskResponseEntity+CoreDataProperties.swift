//
//  TaskResponseEntity+CoreDataProperties.swift
//  Tasks
//
//  Created by Arkadiusz Pituła on 15/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskResponseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskResponseEntity> {
        return NSFetchRequest<TaskResponseEntity>(entityName: "TaskResponseEntity")
    }

    @NSManaged public var created: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var id: Int64
    @NSManaged public var info: String?
    @NSManaged public var status: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var image: String?

}

extension TaskResponseEntity {
    func toModel() -> Task {
        return Task(
            id: Int(id),
            title: title ?? "",
            subtitle: subtitle ?? "",
            info: info ?? "",
            addDate: created ?? "",
            status: Task.Status(value: status ?? ""),
            isFavourite: favourite,
            image: image ?? "")
    }
}
