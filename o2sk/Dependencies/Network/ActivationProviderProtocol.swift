//
//  ActivationProviderProtocol.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//
import Foundation

protocol ActivationProviderProtocol: AnyObject {
    func activate(code: String) async throws -> ActivationResponseModel
}
