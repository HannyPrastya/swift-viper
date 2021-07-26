//
//  CurrencyPickerPresenter.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import RxSwift

final class CurrencyPickerPresenter: BasePresenterContract {
    var viewModel: CurrencyPickerViewModel!
    var router: CurrencyPickerRouter!
    var interactor: CurrencyPickerInteractor!

    private let disposeBag = DisposeBag()

    func viewDidLoad() {
        bindAction()
        observeSupportedCurrencies()
        observeSearching()
    }
    
    private func bindAction(){
        viewModel
            .actionTrigger
            .subscribe(
                onNext: { [weak self] action in
                    switch action {
                        case.tapCancelButton:
                            self?.router.dismiss()
                            break
                        case .selectCurrency:
                            self?.router.dismiss()
                            break
                    }
                }
            ).disposed(by: disposeBag)
    }
    
    private func observeSupportedCurrencies(){
        interactor.getSupportedCurrencies()
            .map({ (rates) -> [Currency] in
                return rates.sorted(by: { $0.code < $1.code })
            })
            .bind(to: viewModel.currencies)
            .disposed(by: disposeBag)
    }
    
    private func observeSearching(){
        Observable
            .combineLatest(viewModel.keyword, viewModel.currencies)
            .observeOn(MainScheduler.instance)
            .map({ [self] (keyword, currencies) -> [Currency] in
                filterCurrencies(currencies: currencies, keyword: keyword)
            })
            .bind(to: viewModel.filteredCurrencies)
            .disposed(by: disposeBag)
    }
    
    func filterCurrencies(currencies: [Currency], keyword: String = "") -> [Currency] {
        return currencies.filter { (currency) -> Bool in
            let name = currency.name ?? ""
            return (currency.code.lowercased().contains(keyword.lowercased()) || name.lowercased().contains(keyword.lowercased()))
                || keyword == ""
        }.sorted{ $0.code < $1.code }
    }
}
