//
//  CurrencyPickerViewModel.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import RxSwift
import RxRelay

// MARK: - UI Actions

public enum CurrencyPickerAction {
    case tapCancelButton
    case selectCurrency
}

// MARK: - View Model

public struct CurrencyPickerViewModel: ViewModelEmittableContract {
    let actionTrigger = PublishRelay<CurrencyPickerAction>()
    let selectedCurrency = PublishSubject<Currency?>()
    let keyword = BehaviorRelay<String>(value: "")
    let currencies = BehaviorRelay<[Currency]>(value: [])
    let filteredCurrencies = BehaviorRelay<[Currency]>(value: [])
}
