//
//  CurrencyMainInteractor.swift
//  LinguisticNative
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//  
//

import Foundation
import RxSwift

final class CurrencyMainInteractor: InteractorContractor {
    weak var presenter: CurrencyMainPresenter!
    
    private let provider = CurrencyLayerProvider()
    
    func getLiveExchange() -> Observable<[ExchangeRate]> {
        return Observable<Int>
        .timer(RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(60 * 30), scheduler: MainScheduler.instance)
        .flatMap { (_) -> Observable<[ExchangeRate]> in
            return self.provider
                .getLiveExchange()
                .catchError { [weak self] error in
                    self?.presenter.presentAlert(error)
                    return .complete()
            }
        }
    }
}
