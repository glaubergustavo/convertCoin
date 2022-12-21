//
//  CoinConvertHistoryTableViewController.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 21/12/22.
//

import UIKit

class CoinConvertHistoryTableViewController: UITableViewController {

    //MARK: - ViewModel
    public var viewModelCoin: CoinConvertViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CoinConvertHistoryTableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModelCoin.numberSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelCoin.numberRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object:Coin = self.viewModelCoin.getHistoryExchange()[indexPath.row]
        let cell:HistoryCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.setTitle(title: object.name ?? "Sem titulo")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModelCoin.coinHistory = self.viewModelCoin.getHistoryExchange()[indexPath.row]
        self.dismiss(animated: true)
    }
}
