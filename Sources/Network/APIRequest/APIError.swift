//
//  File.swift
//  
//
//  Created by Özgür Ersöz on 9.07.2020.
//
import Foundation
enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}
