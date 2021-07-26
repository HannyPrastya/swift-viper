//
//  ApiClient.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Alamofire
import RxSwift
import UIKit
import RxCocoa

//MARK: - Request

public struct APIRequest<T: Codable>: APIRequestContract {
    typealias ResponseType = T
    
    var response: ResponseType? = nil
    var payload: Any? = nil
    
    var url: String
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: Parameters? = nil
}

protocol HTTPClient {
    func call<T>(_ request: T) -> Observable<T.ResponseType> where T: APIRequestContract
}

//MARK: - Client

final class APIClient: HTTPClient {
    static var shared: APIClient = APIClient()
    
    private var manager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        
        let cacher = ResponseCacher(behavior: .cache)
        
        let session = Alamofire.Session(configuration: configuration, cachedResponseHandler: cacher)
        
        return session
    }()
    
    public func call<T>(_ request: T) -> Observable<T.ResponseType> where T: APIRequestContract {
        return Observable<T.ResponseType>.create { observer in
            let task = self.manager.request(
                request.url,
                method: request.method,
                parameters: request.parameters,
                encoding: URLEncoding.default,
                headers: request.headers
            )
            .responseData { (response) in
                switch response.result {
                    case .success(let data) :
                        do {
                            let result = try JSONDecoder().decode(T.ResponseType.self, from: data)
                            observer.onNext(result)
                        } catch {
                            observer.onError(error)
                        }
                        break
                    case .failure(let error):
                        observer.onError(error)
                        break
                }
            }
            
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
