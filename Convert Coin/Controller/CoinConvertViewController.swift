//
//  CoinConvertViewController.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import UIKit
import iOSDropDown

class CoinConvertViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var dropDownTo: DropDown!
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var lblValueConverted: UILabel!
    @IBOutlet weak var txtValueInfo: UITextField!
    @IBOutlet weak var btnConversionHistory: UIButton!
    
    //MARK: - vars/lets
    private var coinUsed:Coin?
    
    //MARK: - ViewModel
    private var viewModelCoin: CoinConvertViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let coin = self.viewModelCoin.coinHistory {
            self.dropDownTo.text = coin.code!
            self.dropDownFrom.text = coin.codein!
        }
    }
    //MARK: - IBActions
    @IBAction func convertCoin(_ sender: UIButton) {
        
        let error = self.validateFilds()
        !error.isEmpty ? self.view.showMessage(viewController: self, message: error) : self.sendParamsToConvertCoin()
        
    }
    
    @IBAction func saveHistory(_ sender: UIButton) {
        
        let error = self.validateFilds()
        !error.isEmpty ? self.view.showMessage(viewController: self, message: error) : self.validateCurrencyConversionHistory()
        
    }
    
    @IBAction func showHistory(_ sender: UIButton) {
        self.performSegue(withIdentifier: "historySegue", sender: nil)
    }
    
    //MARK: - Custom Methods
    private func getCoins(params:String) {
        
            self.viewModelCoin.getCoins(params: params){ (data, error) in
                
                if let coins = data {
                    DispatchQueue.main.async {
                        self.coinUsed = coins.first!.value
                        if let coinFrom:String = self.dropDownFrom.text, let valueInfo:String = self.txtValueInfo.text {
                            
                            let valueCalculated:NSNumber = self.viewModelCoin.calculateCoins(valueInfo: valueInfo, valueCoin: self.coinUsed!.buyValue)
                            self.lblValueConverted.text = .formatCurrency(value: valueCalculated, enumCoin: coinFrom)
                        }
                }
            }
        }
    }
    
    private func validateFilds() -> String {
        var error:String = .Messages.isEmpty
        if self.txtValueInfo.text == .Messages.isEmpty{
            error = .Messages.errorValue
        }else if self.dropDownTo.text == .Messages.isEmpty || self.dropDownFrom.text == .Messages.isEmpty {
            error = .Messages.errorCoins
        }else if self.dropDownTo.text == self.dropDownFrom.text {
            error = .Messages.errorCoinsEquals
        }
        
        return error
    }
    
    private func configUI() {
        self.viewModelCoin = CoinConvertViewModel()
        self.btnConversionHistory.isHidden = self.viewModelCoin.getHistoryExchange().count <= 0
        
        self.configDropDown()
    }
    
    private func configDropDown() {
        self.dropDownTo.optionArray = self.viewModelCoin.getListCoin()
        self.dropDownTo.arrowSize = 5
        self.dropDownTo.selectedRowColor = .gray
        
        self.dropDownFrom.optionArray = self.viewModelCoin.getListCoin()
        self.dropDownFrom.arrowSize = 5
        self.dropDownFrom.selectedRowColor = .gray
    }
    
    private func sendParamsToConvertCoin() {
        
        guard let paramDropDownTo = self.dropDownTo.text else { return }
        guard let paramDropDownFrom = self.dropDownFrom.text else { return }
                
        let params:String = "\(paramDropDownTo)-\(paramDropDownFrom)"
        self.getCoins(params: params)
    }
    
    private func validateCurrencyConversionHistory() {
        
        if let coin = self.coinUsed {
            self.viewModelCoin.saveHistoryExchange(coin: coin) { message in
                self.view.showMessage(viewController: self, message: message)
            }
        }else {
            self.view.showMessage(viewController: self, message: .Messages.convertFirst)
        }
        
        self.btnConversionHistory.isHidden = self.viewModelCoin.getHistoryExchange().count <= 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CoinConvertHistoryTableViewController {
            controller.viewModelCoin = self.viewModelCoin
        }
    }
}
