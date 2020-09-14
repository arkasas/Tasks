//
//  AppDelegate.swift
//  Tasks
//
//  Created by Arkadiusz Pituła on 14/09/2020.
//  Copyright © 2020 arpro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var applicationRouter: ApplicationRouter = {
        BaseApplicationRouter()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return applicationRouter.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}

