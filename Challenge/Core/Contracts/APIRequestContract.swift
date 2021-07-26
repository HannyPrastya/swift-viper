//
//  ApiRequestContract.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Alamofire

protocol APIRequestContract {
    associatedtype ResponseType: Codable
    
    var url: String { get }
    var method: HTTPMethod  { get }
    var headers: HTTPHeaders?  { get }
    var response: ResponseType? { get }
    var parameters: Parameters? { get }
    var payload: Any? { get }
}
