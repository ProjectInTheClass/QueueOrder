//
//  MypageTableViewCell.swift
//  SmartOrder
//
//  Created by Jeong on 10/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
