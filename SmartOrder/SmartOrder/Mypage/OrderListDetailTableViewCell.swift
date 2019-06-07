//
//  OrderListDetailTableViewCell.swift
//  SmartOrder
//
//  Created by Jeong on 02/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class OrderListDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var sizeIceShot: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
