//
//  MockClient.swift
//  ChallengeTests
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import RxSwift
import Alamofire

@testable import Challenge

class MockClient: HTTPClient {
    enum MockResponse {
        case liveExist
        case liveZero
        case listExist
        case listZero
    }
    
    var response: MockResponse = .listExist
    
    var string: String {
        switch response {
            case .liveExist:
                return "{ \"success\": true, \"terms\": \"terms\", \"privacy\": \"privacy\", \"timestamp\": 1607849824, \"source\": \"USD\", \"quotes\": { \"USDAED\": 3.0 } }"
            case .liveZero:
                return "{ \"success\": true, \"terms\": \"terms\", \"privacy\": \"privacy\", \"timestamp\": 1607849824, \"source\": \"USD\", \"quotes\": { } }"
            case .listExist:
                return "{\"success\": true, \"terms\": \"terms\", \"privacy\": \"privacy\", \"currencies\": { \"JPY\" : \"Japanese Yen\"  } }"
            case .listZero:
                return "{\"success\": true, \"terms\": \"terms\", \"privacy\": \"privacy\", \"currencies\": { } }"
        }
    }
    var success: Bool = true
    
    func call<T>(_ request: T) -> Observable<T.ResponseType> where T : APIRequestContract {
        return Observable<T.ResponseType>.create { [self] observer in
            if success {
                do {
                    let result = try JSONDecoder().decode(T.ResponseType.self, from: string.data(using: .utf8)!)
                    observer.onNext(result)
                } catch {
                    observer.onError(error)
                }
            } else {
                observer.onError(AFError.ServerTrustFailureReason.self as! Error)
            }
            
            return Disposables.create()
        }
    }
}
