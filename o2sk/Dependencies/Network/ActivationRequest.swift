//
//  ActivationRequest.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

struct ActivationRequest: CodableAPIRequest {
    typealias Response = ActivationResponseModel
    
    var path: String { return "version?code=\(code)"}
    var httpMethod: HTTPMethod { return .GET }
    
    // Parameters
    let code: String
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
    }

    init(code: String) {
        self.code = code
    }
}
