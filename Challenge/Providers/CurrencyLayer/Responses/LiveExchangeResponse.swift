//
//  LiveCurrencyResponse.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

//MARK: - Response

struct LiveExchangeResponse: Codable {
    let success: Bool
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    var quotes: [ExchangeRate]?
    var error: CurrencyLayerError?
    
    enum CodingKeys: CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
        case error
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        terms = try? values.decode(String.self, forKey: .terms)
        privacy = try? values.decode(String.self, forKey: .privacy)
        timestamp = try? values.decode(Int.self, forKey: .timestamp)
        source = try? values.decode(String.self, forKey: .source)
        error = try? values.decode(CurrencyLayerError.self, forKey: .error)
        
        let raw = try? values.decode([String: Double].self, forKey: .quotes)
        quotes = []
        quotes = raw?.map { (tuple) -> ExchangeRate in
            let (key, value) = tuple
            return ExchangeRate(currency: Currency(code: String(key.suffix(3))), source: Currency(code: source ?? ""), rate: value)
        }
    }
}
