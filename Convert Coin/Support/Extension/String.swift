//
//  String.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import Foundation

extension String {
    
    struct Messages {
        
        public static let isEmpty = ""
        public static let errorValue = "Informe um valor a ser convertido"
        public static let errorCoins = "Selecione as moedas a serem convertidas"
        public static let errorCoinsEquals = "Selecione moedas diferentes"
        public static let errorSavedHistory = "Você já salvou um histórico para essa pesquisa"
        public static let savedHistory = "Histórico Salvo com sucesso!"
        public static let convertFirst = "Você primeiro precisa fazer a conversão, para salvar"

    }
    
    public static func formatCurrency(value:NSNumber, enumCoin:String) -> String {
        var locale:String = .Messages.isEmpty
        
        switch enumCoin {
            case EnumCoins.USD.rawValue:
                locale = "en-US"
            case EnumCoins.BRL.rawValue:
                locale = "pt-BR"
            case EnumCoins.EUR.rawValue:
                locale = "pt-PT"
            default:
                locale = "pt-BR"
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value as NSNumber) {
            return formattedTipAmount
        }
        return .Messages.isEmpty
    }
}
