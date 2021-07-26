//
//  CurrencyPickerModule.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Module Builder

final class CurrencyPickerModule: SceneContract {
    typealias View = CurrencyPickerView
    typealias Presenter = CurrencyPickerPresenter
    typealias Router = CurrencyPickerRouter
    typealias Interactor = CurrencyPickerInteractor
    
    let presenter = Presenter()
    let interactor = Interactor()
    let router = Router()
    let viewModel = CurrencyPickerViewModel()
    let view = View()

    public func build() -> UIViewController {
        view.presenter = presenter
        view.viewModel = viewModel
        
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        
        router.presenter = presenter
        
        interactor.presenter = presenter
        return view
    }
    
    public func selectedCurrency() -> Observable<Currency?> {
        return viewModel.selectedCurrency
    }
}
