//
//  MypageTableViewCell.swift
//  SmartOrder
//
//  Created by Jeong on 15/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageTableViewCell: UITableViewCell {
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var dayInfo: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
