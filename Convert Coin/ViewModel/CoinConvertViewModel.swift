//
//  CoinConvertViewModel.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import Foundation

class CoinConvertViewModel {
    
    private var exchangeUserDefault:ExchangeUserDefault = ExchangeUserDefault()
    
    public var coinHistory:Coin?
    
    public var numberRows: Int {
        return self.getHistoryExchange().count
    }
    
    public var numberSections: Int {
        return 1
    }
    
    public func getCoins(params:String,
                         onCompletion: @escaping (ExchangeCoins?, String?) -> Void) {
        WebService().getCoins(pathParam: params) { (data, error)  in
            if let coins = data {
                onCompletion(coins, nil)
            }else {
                onCompletion(nil, error)
            }
        }
    }
    
    public func calculateCoins(valueInfo:String, valueCoin:String) -> NSNumber {
        guard let value:Float = Float(valueInfo) else { return 0}
        guard let coin:Float = Float(valueCoin) else { return 0}
        
        let calculate:Float = coin * value
        
        return NSNumber(value: calculate)
    }
    
    public func getListCoin() -> [String] {
        return EnumCoins.allCases.map{$0.rawValue}
    }
    
    public func saveHistoryExchange(coin:Coin, onCompletion: @escaping (String) -> Void) {
        var listCoins:[Coin] = self.getHistoryExchange()
        if listCoins.count > 0 {
            let listAux = listCoins.filter {$0.code == coin.code && $0.codein == coin.codein}
            if listAux.count > 0 {
                onCompletion(.Messages.errorSavedHistory)
            }else {
                listCoins.append(coin)
                self.exchangeUserDefault.save(listCoin: listCoins)
                onCompletion(.Messages.savedHistory)
            }
        }else {
            listCoins.append(coin)
            self.exchangeUserDefault.save(listCoin: listCoins)
            onCompletion(.Messages.savedHistory)
        }
    }
    
    public func getHistoryExchange() -> [Coin] {
        return self.exchangeUserDefault.getListCoins()
    }
}
