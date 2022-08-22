//
//  APIManager.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation
import Alamofire

enum Result<T: Decodable> {
    case success(T)
    case error(RequestError)
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError
    case serverError
}

struct EmptyRequest: Encodable { }

class APIManager {
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.httpAdditionalHeaders = AF.sessionConfiguration.httpAdditionalHeaders
        return Session(configuration: configuration)
    }()
    
    init() { }
    
    func request<R: Encodable, T: Decodable>(
        method: HTTPMethod = .get,
        parameters: R,
        endpoint: EndPoint,
        _ completionHandler: @escaping (Result<T>) -> Void
    ) {
        
        guard let url = URL(string: endpoint.path) else { return }
        
        let decoder = self.decoder
        let encoder: ParameterEncoder
        
        if method == .get {
            encoder = URLEncodedFormParameterEncoder.default
        } else {
            encoder = JSONParameterEncoder.default
        }
        
        session.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder
        ).validate().responseData { response in
            let statusCode = response.response?.statusCode ?? 0
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200:
                    do {
                        let objs = try decoder.decode(T.self, from: data)
                        completionHandler(.success(objs))
                    } catch {
                        completionHandler(.error(.unknownError))
                    }
                case 400...499:
                    completionHandler(.error(.authorizationError))
                case 500...599:
                    completionHandler(.error(.authorizationError))
                default:
                    completionHandler(.error(.unknownError))
                }
            case .failure:
                completionHandler(.error(.unknownError))
            }
        }
    }
}
