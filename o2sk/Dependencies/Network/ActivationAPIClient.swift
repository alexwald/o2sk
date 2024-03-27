//
//  ActivationAPIClient.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

public class ActivationAPIClient: APIClient, ActivationProviderProtocol {
    
    let session: URLSession
    let host: String
    
    let jsonDecoder: JSONDecoder = JSONDecoder()
    let urlFormEncoder: URLEncodedFormEncoder = URLEncodedFormEncoder()

    required init(host: String, session: URLSession) {
        self.host = host
        self.session = session
    }
    
    func activate(code: String) async throws -> ActivationResponseModel {
        let request = ActivationRequest(code: code)
        return try await send(request, authentication: .none)
    }
}
