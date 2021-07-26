//
//  Currency.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Foundation

struct Currency: Codable, Equatable {
    let code: String
    var name: String? = nil
}
