//
//  SupportedCurrencyResponse.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

//MARK: - Response

struct SupportedCurrencyResponse: Codable {
    let success: Bool
    let terms, privacy: String?
    let currencies: [Currency]?
    var error: CurrencyLayerError?
    
    enum CodingKeys: CodingKey {
        case success
        case terms
        case privacy
        case currencies
        case error
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        terms = try? values.decode(String.self, forKey: .terms)
        privacy = try? values.decode(String.self, forKey: .privacy)
        error = try? values.decode(CurrencyLayerError.self, forKey: .error)
        
        let raw = try? values.decode([String: String].self, forKey: .currencies)
        
        currencies = raw?.map { (tuple) -> Currency in
            let (key, value) = tuple
            return Currency(code: key, name: value)
        }
    }
}
