//
//  CardDependencies.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//
import Foundation

class CardDependencies {
    // MARK: - Networking clients
    public let activationClient: ActivationProviderProtocol
    public let activationValidator: ActivationValidator

    public init(host: String, session: URLSession = .shared) {
        self.activationClient = ActivationAPIClient(host: host, session: session)
        self.activationValidator = ActivationValidator()
    }
}
