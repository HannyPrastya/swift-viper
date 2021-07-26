//
//  SwinjectService.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import UIKit
import Swinject

//MARK: - preparation only

final class SwinjectService: NSObject, AppServiceContract {
    var container = Container()
    var assembler = Assembler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        assembler = Assembler(
            [
                HelperAssembly()
            ],
            container: container
        )

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        return false
    }
}

