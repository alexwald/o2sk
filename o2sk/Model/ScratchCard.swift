//
//  ScratchCard.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import Foundation

enum ScratchCardState: String, Decodable {
    case unscratched
    case scratched
    case activated
    
    func localizedString() -> String {
           return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct ScratchCard: Decodable {
    let code: String
    let state: ScratchCardState
    
    enum CodingKeys: String, CodingKey {
        case code
        case state
    }
    
    init(code: String, state: ScratchCardState) {
        self.code = code
        self.state = state
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        state = try container.decode(ScratchCardState.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(state.rawValue, forKey: .state)
    }
}
