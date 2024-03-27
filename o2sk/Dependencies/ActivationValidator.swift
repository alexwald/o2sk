//
//  ActivationValidator.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

class ActivationValidator {
    func isActivationValidFrom(response: ActivationResponseModel) -> Bool {
        if let double = Double(response.ios) {
            return double > 6.1
        } else {
            return false
        }
    }
}
