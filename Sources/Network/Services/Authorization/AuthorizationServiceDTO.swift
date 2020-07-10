//
//  File.swift
//  
//
//  Created by Özgür Ersöz on 10.07.2020.
//

import Foundation

extension AuthenticationService {
    enum AnonymousToken {
        struct Response: Decodable {
            let token: String
            let scope: String
            let type: String
            let expire: Int
        }
    }
    
    enum Login {
        struct Request: Encodable {
            let username: String
            let password: String
        }
        
        struct Response: Decodable {
            let token: String
            let scope: String
            let type: String
            let expire: Int
        }
    }
}
