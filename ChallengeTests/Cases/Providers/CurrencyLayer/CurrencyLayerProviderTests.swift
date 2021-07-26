//
//  CurrencyLayerProviderTests.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
import RxBlocking

@testable import Challenge

class CurrencyLayerProviderTest: QuickSpec {
    override func spec() {
        let client = MockClient()
        let provider = CurrencyLayerProvider(client: client)
        var currencies: [Currency] = []
        
        describe("Request for Supported Currencies") {
            it("will be zero") {
                client.response = .listZero
                currencies = []
                expect(try provider.getSupportedCurrencies().toBlocking().first()!).to(equal(currencies))
            }
            
            it("will be 1 currency") {
                client.response = .listExist
                currencies = [Currency(code: "JPY", name: "Japanese Yen")]
                expect(try provider.getSupportedCurrencies().toBlocking().first()!).to(equal(currencies))
            }
        }
        
        var rates: [ExchangeRate] = []
        
        describe("Request for Live Exchange") {
            it("will be zero") {
                client.response = .liveZero
                rates = []
                expect(try provider.getLiveExchange().toBlocking().first()!).to(equal(rates))
            }
            
            it("will be 1 exchange rate") {
                client.response = .liveExist
                rates = [ExchangeRate(currency: Currency(code: "AED"), source: Currency(code:  "USD"), rate: 3.0)]
                expect(try provider.getLiveExchange().toBlocking().first()!).to(equal(rates))
            }
        }
    }
}
