//
//  CartOrderInfoCell.swift
//  SmartOrder
//
//  Created by 하영 on 14/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CartOrderInfoCell: UITableViewCell {
    
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //orderBtn.backgroundColor = .clear
        orderBtn.backgroundColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0)
        orderBtn.layer.cornerRadius = 5
        orderBtn.layer.borderWidth = 1
        orderBtn.layer.borderColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0).cgColor
        
        
        // Configure the view for the selected state
    }
    
}
