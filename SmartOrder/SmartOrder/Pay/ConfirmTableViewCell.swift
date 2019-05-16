//
//  ConfirmTableViewCell.swift
//  SmartOrder
//
//  Created by Ing on 16/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class ConfirmTableViewCell: UITableViewCell {

    let confirmController = UIAlertController(title: "쿠폰을 사용하시겠습니까?", message:
        "", preferredStyle: .alert)
    let cancelController = UIAlertController(title: "쿠폰 사용을 취소하시겠습니까?", message : "", preferredStyle : .alert)
   
    var confirmed: Bool = false
    var canceled: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        confirmController.addAction(UIAlertAction(title: "확인", style: .default){
            UIAlertAction in
            self.confirmed = true
            
        })
        confirmController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        
        cancelController.addAction(UIAlertAction(title: "확인", style: .default){
            UIAlertAction in
            
            self.canceled = true
            
        })
        cancelController.addAction(UIAlertAction(title: "취소", style: .cancel))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}
