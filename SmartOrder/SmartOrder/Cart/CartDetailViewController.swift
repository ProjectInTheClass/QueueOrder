//
//  CartDetailViewController.swift
//  SmartOrder
//
//  Created by 하영 on 08/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CartDetailViewController: UIViewController {
    var CartForView:Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CartForView?.coffee)
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
