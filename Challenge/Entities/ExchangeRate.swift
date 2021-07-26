//
//  ExchangeRate.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

struct ExchangeRate: Codable, Equatable {
    var currency: Currency
    var source: Currency
    var rate: Double
    var total: Double = 0
}
