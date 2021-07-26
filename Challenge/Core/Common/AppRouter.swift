//
//  AppRouter.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import UIKit

class AppRouter {
    static let shared = AppRouter()

    var rootViewController: UINavigationController  = {
        let viewController = CurrencyMainModule().build()
        return UINavigationController(rootViewController: viewController)
    }()
}
