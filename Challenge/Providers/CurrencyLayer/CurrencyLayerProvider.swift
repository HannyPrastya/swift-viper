//
//  CurrencyLayerProvider.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Alamofire
import RxSwift

final class CurrencyLayerProvider {
    private let disposeBag = DisposeBag()
    var client: HTTPClient
    
    init(client: HTTPClient = APIClient()) {
        self.client = client
    }

    func getSupportedCurrencies() -> Observable<[Currency]> {
        return Observable<[Currency]>.create { [self] (observer) -> Disposable in
            let request = APIRequest<SupportedCurrencyResponse>(url: "\(ApiConfig.baseURL)/list", method: .get, headers: nil, parameters: ApiConfig.parameters)
            client.call(request).subscribe(onNext: { (response) in
                if response.success {
                    observer.onNext(response.currencies ?? [])
                } else {
                    if let error = response.error {
                        observer.onError(error)
                    }
                }
            }, onError: { (error) in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            }).disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
    func getLiveExchange() -> Observable<[ExchangeRate]> {
        return Observable<[ExchangeRate]>.create { [self] (observer) -> Disposable in
            let request = APIRequest<LiveExchangeResponse>(url: "\(ApiConfig.baseURL)/live", method: .get, headers: nil, parameters: ApiConfig.parameters)
            client.call(request).subscribe(onNext: { (response) in
                if response.success {
                    observer.onNext(response.quotes ?? [])
                } else {
                    if let error = response.error {
                        observer.onError(error)
                    }
                }
            }, onError: { (error) in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            }).disposed(by: disposeBag)
            return Disposables.create()
        }
    }
}
