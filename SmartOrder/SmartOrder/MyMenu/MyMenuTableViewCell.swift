//
//  MyMenuTableViewCell.swift
//  SmartOrder
//
//  Created by Ing on 07/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MyMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var MenuImage: UIImageView!
    @IBOutlet weak var MenuName: UILabel!
    @IBOutlet weak var MenuPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
