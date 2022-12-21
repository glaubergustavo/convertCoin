//
//  UserDefault.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 21/12/22.
//

import Foundation

class ExchangeUserDefault {
    
    let kHistoy:String = "kHistory"
    
    public func save(listCoin: [Coin]) {
        do  {
            let list = try JSONEncoder().encode(listCoin)
            UserDefaults.standard.setValue(list, forKey: self.kHistoy)
        } catch {
            print(error)
        }
    }
    
    public func getListCoins() -> [Coin] {
        do  {
            guard let list = UserDefaults.standard.object(forKey: self.kHistoy) else { return []}
            let listAux = try JSONDecoder().decode([Coin].self, from: list as! Data)
            
            return listAux
            
        } catch {
            print(error)
        }
        return []
    }
}
