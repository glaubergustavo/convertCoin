//
//  HistoryCell.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 21/12/22.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func setTitle(title:String) {
        self.lblTitle.text = title
    }

}
