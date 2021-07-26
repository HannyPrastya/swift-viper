//
//  CurrenyMainPresenterTests.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Quick
import Nimble

@testable import Challenge

class CurrenyMainPresenterTests: QuickSpec {
    override func spec() {
        let presenter = CurrencyMainPresenter()
        
        var rates: [ExchangeRate] = []
        var selectedCurrency: Currency = Currency(code: "JPY")
        var amount: String = ""
        
        describe("Calculate based on amount, rates and selected currency") {
            it("will be 0 on total property on each rate with amount 0") {
                rates = [ExchangeRate(currency: Currency(code: "JPY"), source: Currency(code:"USD"), rate: 10, total: 0), ExchangeRate(currency: Currency(code: "USD"), source: Currency(code:"USD"), rate: 1, total: 0)]
                selectedCurrency = Currency(code: "USD")
                amount = ""
                
                expect(presenter.calculateExchangeRates(amount: amount, rates: rates, currency: selectedCurrency)).to(equal(rates))
            }
            
            it("will be 0 on total property on each rate with amount x") {
                rates = [ExchangeRate(currency: Currency(code: "JPY"), source: Currency(code:"USD"), rate: 10, total: 0), ExchangeRate(currency: Currency(code: "USD"), source: Currency(code:"USD"), rate: 1, total: 0)]
                selectedCurrency = Currency(code: "USD")
                amount = "x"
                
                expect(presenter.calculateExchangeRates(amount: amount, rates: rates, currency: selectedCurrency)).to(equal(rates))
            }
            
            it("will be 100 on total property on each rate with input 0") {
                rates = [ExchangeRate(currency: Currency(code: "JPY"), source: Currency(code:"USD"), rate: 10, total: 100), ExchangeRate(currency: Currency(code: "USD"), source: Currency(code:"USD"), rate: 1, total: 10)]
                selectedCurrency = Currency(code: "USD")
                amount = "10"
                
                expect(presenter.calculateExchangeRates(amount: amount, rates: rates, currency: selectedCurrency)).to(equal(rates))
            }
            
            it("will select JPY") {
                rates = [ExchangeRate(currency: Currency(code: "JPY"), source: Currency(code:"USD"), rate: 10, total: 0), ExchangeRate(currency: Currency(code: "USD"), source: Currency(code:"USD"), rate: 1, total: 0)]
                selectedCurrency = Currency(code: "JPY")
                amount = "0"
                
                let newRates = [ExchangeRate(currency: Currency(code: "JPY"), source: Currency(code:"JPY"), rate: 1, total: 0), ExchangeRate(currency: Currency(code: "USD"), source: Currency(code:"JPY"), rate: 0.1, total: 0)]
                
                expect(presenter.calculateExchangeRates(amount: amount, rates: rates, currency: selectedCurrency)).to(equal(newRates))
            }
        }
    }
}
