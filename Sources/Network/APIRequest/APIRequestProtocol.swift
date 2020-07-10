//
//  File.swift
//  
//
//  Created by Özgür Ersöz on 8.07.2020.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

protocol APIRequestProtocol: URLRequestConvertible {
    init(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: Encodable?, header: APIRequest.HeaderType?)

    func request(for url: URL) throws -> URLRequest
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}
