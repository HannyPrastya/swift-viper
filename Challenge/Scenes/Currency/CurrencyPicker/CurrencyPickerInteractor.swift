//
//  CurrencyPickerInteractor.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import RxSwift

final class CurrencyPickerInteractor: InteractorContractor {
    weak var presenter: CurrencyPickerPresenter!
    
    private let provider = CurrencyLayerProvider()
    
    func getSupportedCurrencies(_ keyword: String = "") -> Observable<[Currency]> {
//        Having a behavior like rate, to limit the bandwith usage
        return Observable<Int>
            .timer(RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(60 * 30), scheduler: MainScheduler.instance)
            .flatMap { [self] (_) -> Observable<[Currency]> in
                return provider
                    .getSupportedCurrencies()
                    .catchError { [weak self] error in
                        self?.presenter.presentAlert(error)
                        return .complete()
                    }
            }
    }
}
