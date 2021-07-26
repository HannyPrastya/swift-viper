//
//  CurrencyMainModule.swift
//  LinguisticNative
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//  
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

// MARK: - Module Builder

final class CurrencyMainModule: SceneContract {
    typealias View = CurrencyMainView
    typealias Presenter = CurrencyMainPresenter
    typealias Router = CurrencyMainRouter
    typealias Interactor = CurrencyMainInteractor

    private let presenter = Presenter()
    private let interactor = Interactor()
    private let router = Router()

    private let viewModel = CurrencyMainViewModel()
    private let view = View()
    
    func build() -> UIViewController {
        view.presenter = presenter
        view.viewModel = viewModel

        presenter.viewModel = viewModel
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        return view
    }
}
