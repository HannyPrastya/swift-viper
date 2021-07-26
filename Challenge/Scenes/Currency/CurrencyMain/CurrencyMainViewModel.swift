//
//  CurrencyMainViewModel.swift
//  LinguisticNative
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//  
//

import Foundation
import RxSwift
import RxRelay

// MARK: - UI Actions

public enum CurrencyMainAction {
    case tapCurrency
}

// MARK: - ViewModel

class CurrencyMainViewModel: ViewModelEmittableContract {
    let actionTrigger = PublishRelay<CurrencyMainAction>()
    let selectedCurrency = BehaviorRelay<Currency>(value: Currency(code: "USD", name: "United State Dollar"))
    let exchangeRates = BehaviorRelay<[ExchangeRate]>(value: [])
    let amount = BehaviorRelay<String?>(value: "1")
    let error = PublishSubject<Error>()
    let isLoading = PublishSubject<Bool>()
}
