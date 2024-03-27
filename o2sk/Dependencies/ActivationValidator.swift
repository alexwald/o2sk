//
//  ActivationValidator.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

class ActivationValidator {
    func isActivationValidFrom(response: ActivationResponseModel) -> Bool {
        if let doulbe = Double(response.ios) {
            return doulbe > 6.1
        } else {
            return false
        }
    }
}
