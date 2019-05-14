//
//  MypageDetailViewController.swift
//  SmartOrder
//
//  Created by Jeong on 14/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageDetailViewController: UIViewController {

    var orderInfo : Order?
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label1.text = "\(orderInfo?.caffeInfo)"
        Label2.text = orderInfo?.coffee
        Label3.text = "\(orderInfo?.price)"
        Label4.text = orderInfo?.ice
        Label5.text = orderInfo?.orderDate
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
