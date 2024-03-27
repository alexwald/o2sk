//
//  ActivationResponseModel.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

struct ActivationResponseModel: Decodable {
    let ios: String
    
    private enum CodingKeys: String, CodingKey {
        case ios
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ios = try container.decode(String.self, forKey: .ios)
    }
}
