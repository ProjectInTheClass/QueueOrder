//
//  CartTableViewCell.swift
//  SmartOrder
//
//  Created by 하영 on 09/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cnt: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var select: UIImageView!
    
    var isSelect = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    @IBAction func onClick(_ sender: Any) {
        
        if(isSelect) {
            select.image = UIImage(named: "selected")
        } else {
            select.image = UIImage(named: "notSelected")
        }
        
        isSelect = !isSelect
    }
    
}
