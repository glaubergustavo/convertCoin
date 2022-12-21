//
//  ErrorResponse.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import Foundation

class ErrorResponse: Codable {
    let status: Int
    let code: String
    let message: String
    
    enum codingKeys: String, CodingKey {
        case status, code, message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try values.decode(Int.self, forKey: .status)
        self.code = try values.decode(String.self, forKey: .code)
        self.message = try values.decode(String.self, forKey: .message)
    }
}
