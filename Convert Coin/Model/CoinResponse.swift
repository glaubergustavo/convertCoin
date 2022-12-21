//
//  CoinResponse.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import Foundation

typealias ExchangeCoins = [String : Coin]

class Coin: Codable {
    let code:String?, codein:String?, name:String?, high: String
    let low, varBid, pctChange, buyValue, sellValue: String
    
    enum CodingKeys: String, CodingKey {
        case code, codein, name, high, low, varBid, pctChange
        case buyValue = "bid"
        case sellValue = "ask"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try values.decodeIfPresent(String.self, forKey: .code)
        self.codein = try values.decodeIfPresent(String.self, forKey: .codein)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.high = try values.decode(String.self, forKey: .high)
        self.low = try values.decode(String.self, forKey: .low)
        self.varBid = try values.decode(String.self, forKey: .varBid)
        self.pctChange = try values.decode(String.self, forKey: .pctChange)
        self.buyValue = try values.decode(String.self, forKey: .buyValue)
        self.sellValue = try values.decode(String.self, forKey: .sellValue)
    }
}
