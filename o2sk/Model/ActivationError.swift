//
//  ActivationError.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

enum ActivationError: String, Error {
    case invalidRequest
    case invalidCode
}

extension ActivationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return NSLocalizedString("Code Activation Failed", comment: "invalid request error")
        case .invalidCode:
            return NSLocalizedString("Code is invalid", comment: "invalid code error")
        }
    }
}
