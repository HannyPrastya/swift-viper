//
//  CurrencyMainRouter.swift
//  LinguisticNative
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//  
//

import Foundation
import RxSwift

final class CurrencyMainRouter: RouterContract {
    weak var presenter: CurrencyMainPresenter!
    
    func toCurrencyPicker() -> Observable<Currency?> {
        let module = CurrencyPickerModule()
        AppRouter.shared
            .rootViewController
            .pushViewController(module.build(), animated: true)
        return module.selectedCurrency()
    }
}
