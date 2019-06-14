//
//  GaugeCollectionViewCell.swift
//  SmartOrder
//
//  Created by Ing on 13/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class GaugeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var Base: UIView!
    @IBOutlet var CaffeImage: UIImageView!
    @IBOutlet var CaffeName: UILabel!
    @IBOutlet var Gauge: UIView!
    @IBOutlet var rate: NSLayoutConstraint!
    @IBOutlet var Boundaries: UIView!
    @IBOutlet var HowMany: UILabel!
    
    var couponCreate = UIAlertController()
    var stamp : Int = 0
    var toStamp : Int = 0
}
