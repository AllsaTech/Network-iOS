//
//  File.swift
//  
//
//  Created by Özgür Ersöz on 9.07.2020.
//

import Foundation

class APIRequest: APIRequestProtocol {
    
    fileprivate let method: HTTPMethod
    fileprivate let path: String
    fileprivate let queryItems: [URLQueryItem]
    fileprivate let body: Encodable?
    fileprivate let header: HeaderType?

    required init(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], body: Encodable? = nil, header: HeaderType? = .standart) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.body = body
        self.header = header
    }
    
    func request(for url: URL) throws -> URLRequest {
        do {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            header?.value.forEach({ (field, value) in
                request.addValue(value, forHTTPHeaderField: field)
            })
            
            if let body = body {
                request.httpBody = try body.encoded()
            }
            
            return request
        } catch let error {
            print("something went wrong while serializing the parameters: \(error)")
            throw APIError.apiError(reason: "Wrong url")
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try asURL()
        return try request(for: url)
    }
    
    func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = EnvironmentSettings.api.host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url  else {
            throw APIError.apiError(reason: "invalid url")
        }
        return url
    }
}

extension APIRequest {
    enum HeaderType {
        case standart
        case custom(_ header: HTTPHeaders)
        
        var value: HTTPHeaders {
            switch self {
            case .custom(let headers):
                return headers
            case .standart:
                let headers: HTTPHeaders = [
                    "content-type": "application/json; charset=utf-8 "
                ]
                return headers
            }
        }
    }
}


extension Encodable {
    func encoded(_
        keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase
    ) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        return try encoder.encode(self)
    }
    
    func urlQueryItems() -> [URLQueryItem] {
        let queryItemEncoder = URLQueryItemEncoder()
        do {
            return try queryItemEncoder.encode(self)
        } catch {
            return []
        }
    }
}


