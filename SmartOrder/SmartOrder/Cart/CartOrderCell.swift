//
//  CartOrderCell.swift
//  SmartOrder
//
//  Created by 하영 on 15/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CartOrderCell: UITableViewCell{

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cnt: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var option: UILabel!
    @IBOutlet weak var selectBox: UIButton!
    @IBOutlet weak var cartNumber: UILabel!
    var isSelect = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
 
    
    @IBAction func selectBtnClick(_ sender: Any) {
       
        let number:Int = Int(cartNumber.text!)!
   
        
        if(isSelect) {
            selectBox.setImage(UIImage(named: "checked30"), for: UIControl.State.normal)
            cartSelectedArray[number] = 1
          
        } else {
            selectBox.setImage(UIImage(named: "Unchecked30"), for: UIControl.State.normal)
            cartSelectedArray[number] = 0
        }
        
     
        //UITableView().reloadData()
        
        //UITableView.reloadData(CartViewController)
        isSelect = !isSelect
    }
    
    
}
