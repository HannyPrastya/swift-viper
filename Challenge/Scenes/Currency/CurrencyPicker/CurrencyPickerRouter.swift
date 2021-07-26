//
//  CurrencyPickerRouter.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

protocol CurrencyPickerDelegate {
    func setSelectedCurrency(for currency: Currency)
}

final class CurrencyPickerRouter: RouterContract {
    weak var presenter: CurrencyPickerPresenter!
    
    func dismiss(){
        AppRouter.shared.rootViewController.popViewController(animated: true)
    }
}
