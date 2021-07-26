//
//  RequestConversationPresenter.swift
//  LinguisticNative
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//  
//

import Foundation
import RxSwift

final class CurrencyMainPresenter: BasePresenterContract {
    var router: CurrencyMainRouter!
    var interactor: CurrencyMainInteractor!
    var viewModel: CurrencyMainViewModel!
    private let disposeBag = DisposeBag()
}

extension CurrencyMainPresenter {
    func viewDidLoad() {
        bindAction()
        observeAmountAndCurrencies()
    }
    
    private func bindAction() {
        viewModel
            .actionTrigger
            .subscribe(
                onNext: { [self] action in
                    switch action {
                    case .tapCurrency:
                        self.router.toCurrencyPicker()
                            .compactMap({$0})
                            .take(1)
                            .bind(to: viewModel.selectedCurrency)
                            .disposed(by: disposeBag)
                        break
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeAmountAndCurrencies(){
        Observable
            .combineLatest(
                viewModel.amount,
                interactor.getLiveExchange().do(
                    onError: { [self] (error) in
                        presentAlert(error)
                    }),
                viewModel.selectedCurrency)
            .observeOn(MainScheduler.instance)
            .map({ [self] (amount, rates, currency) -> [ExchangeRate] in
                calculateExchangeRates(amount: amount, rates: rates, currency: currency)
            })
            .bind(to: viewModel.exchangeRates)
            .disposed(by: disposeBag)
    }
    
    
    func calculateExchangeRates(amount: String?, rates: [ExchangeRate], currency: Currency) -> [ExchangeRate] {
        if let selectedRate: ExchangeRate = rates.first(where: { $0.currency.code == currency.code && $0.source.code != currency.code }) {
            return rates.map { (rate) -> ExchangeRate in
                var newRate = rate
                newRate.source = selectedRate.currency
                newRate.rate = newRate.rate / selectedRate.rate
                newRate.total = (amount?.toDouble() ?? 0) * newRate.rate
                return newRate
            }.sorted{ $0.currency.code < $1.currency.code }
        } else {
            return rates.map { (rate) -> ExchangeRate in
                var newRate = rate
                newRate.total = (amount?.toDouble() ?? 0) * newRate.rate
                return newRate
            }.sorted{ $0.currency.code < $1.currency.code }
        }
    }
}
