//
//  File.swift
//  
//
//  Created by Özgür Ersöz on 10.07.2020.
//

import Foundation
import Combine

protocol AuthenticationServiceProtocol {
    func getAnonymousToken() -> AnyPublisher<AuthenticationService.AnonymousToken.Response, APIError>
    func login(withRequestParams request: AuthenticationService.Login.Request) -> AnyPublisher<AuthenticationService.Login.Response, APIError>
}

class AuthenticationService: AuthenticationServiceProtocol {
    
    func getAnonymousToken() -> AnyPublisher<AnonymousToken.Response, APIError> {

        let anonymousTokenRequest = APIRequest(
            method: .get,
            path: "/api/Auth/anonymousToken"
        )
        
        return Network()
            .loadData(withRequest: anonymousTokenRequest)
            .decode(type: AnonymousToken.Response.self, decoder: JSONDecoder())
            .mapError({ (error) -> APIError in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            })
            .eraseToAnyPublisher()
    }
    
    func login(withRequestParams request: Login.Request) -> AnyPublisher<Login.Response, APIError> {
        
        let loginRequest = APIRequest(
            method: .post,
            path: "/api/Auth/login",
            body: try? request.encoded(.useDefaultKeys)
        )
                
        return Network()
            .loadData(withRequest: loginRequest)
            .decode(type: Login.Response.self, decoder: JSONDecoder())
            .mapError({ (error) -> APIError in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            })
            .eraseToAnyPublisher()
    }
    
}
