//
//  CurrencyLayerError.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

// MARK: - Error
struct CurrencyLayerError: Codable, AppErrorContract {
    var message: String
    let code: Int
    let info: String
    
    enum CodingKeys: CodingKey {
        case code
        case info
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        message = try values.decode(String.self, forKey: .info)
        info = try values.decode(String.self, forKey: .info)
    }
}

