//
//  ViperContract.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import Swinject

//MARK: - VIPER

public protocol RouterContract {
    associatedtype Presenter

    var presenter: Presenter! { get set }
}

public protocol InteractorContractor {
    associatedtype Presenter

    var presenter: Presenter! { get set }
}

public protocol PresenterContract {
    associatedtype Router
    associatedtype Interactor
    associatedtype ViewModel

    var router: Router! { get set }
    var interactor: Interactor! { get set }
    var viewModel: ViewModel! { get set }
}

public protocol ViewContract {
    associatedtype Presenter
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    var presenter: Presenter! { get set }
}

// MARK: - Module
public protocol SceneContract {
    associatedtype View where View: ViewContract
    associatedtype Presenter where Presenter: PresenterContract
    associatedtype Router where Router: RouterContract
    associatedtype Interactor where Interactor: InteractorContractor
}

