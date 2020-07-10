//
//  Environment.swift
//  
//
//  Created by Özgür Ersöz on 9.07.2020.
//

import Foundation

struct EnvironmentSettings {
    static let api: Environment = .test
}

extension EnvironmentSettings {
    enum Environment: String {
        case test = "api.test.allsa.se"
        case production = "flex-api.sharetribe.com"
        
        var host: String {
            self.rawValue
        }
    }
}
