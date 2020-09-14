//
//  StoryboardInstantiable.swift
//  Tasks
//
//  Created by Arkadiusz Pituła on 14/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var name: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var name: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(name)")
        }
        return vc
    }
}
