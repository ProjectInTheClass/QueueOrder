//
//  CaffePreViewController.swift
//  SmartOrder
//
//  Created by 하영 on 10/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CaffePreViewController: UIViewController {

    var caffeForView:Caffe?
    
    @IBOutlet weak var storePhoto: UIImageView!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var detailed: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(caffeForView?.logo)
        print(caffeForView?.photo)
        // Do any additional setup after loading the view.
        
        let name = caffeForView?.name
        detailed.text = "\(name!)를 선택하시겠어요?"
        if caffeForView?.photo != nil {
            let photo = caffeForView?.photo
            storePhoto.image = UIImage(named: photo!)
        } else {
            storePhoto.image = UIImage(named: "dummy")
        }
        
        storeLocation.text = caffeForView?.name
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
