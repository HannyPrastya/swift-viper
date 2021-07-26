//
//  CurrencyPickerPresenterTests.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation
import Quick
import Nimble

@testable import Challenge

class CurrenyPickerPresenterTests: QuickSpec {
    override func spec() {
        let presenter = CurrencyPickerPresenter()
        
        let currencies: [Currency] = [Currency(code: "JPY", name: "Japanese Yen")]
        var filteredCurrencies: [Currency] = [Currency(code: "JPY", name: "Japanese Yen")]
        var keyword: String = ""
        
        describe("Filter found") {
            it("will be 1 record without keyword") {
                keyword = "jp"
                filteredCurrencies = [Currency(code: "JPY", name: "Japanese Yen")]
                expect(presenter.filterCurrencies(currencies: currencies)).to(equal(filteredCurrencies))
            }
            it("will be 1 record with jp keyword for code property") {
                keyword = "jp"
                filteredCurrencies = [Currency(code: "JPY", name: "Japanese Yen")]
                expect(presenter.filterCurrencies(currencies: currencies, keyword: keyword)).to(equal(filteredCurrencies))
            }
            it("will be 1 record with ja keyword for name property") {
                keyword = "ja"
                filteredCurrencies = [Currency(code: "JPY", name: "Japanese Yen")]
                expect(presenter.filterCurrencies(currencies: currencies, keyword: keyword)).to(equal(filteredCurrencies))
            }
        }
        
        describe("Filter not found") {
            it("will be 0 record with usd keyword") {
                keyword = "usd"
                filteredCurrencies = []
                expect(presenter.filterCurrencies(currencies: currencies, keyword: keyword)).to(equal(filteredCurrencies))
            }
        }
    }
}
