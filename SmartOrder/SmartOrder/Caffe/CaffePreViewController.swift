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
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    
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
        
        storeLocation.text = caffeForView?.location

        //noBtn.backgroundColor = .clear
        noBtn.backgroundColor = UIColor.white
        noBtn.layer.cornerRadius = 5
        noBtn.layer.borderWidth = 1
        noBtn.layer.borderColor = UIColor.white.cgColor
        //noBtn.layer.borderColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0).cgColor
        
        //yesBtn.backgroundColor = .clear
        //yesBtn.backgroundColor = UIColor.white
        yesBtn.backgroundColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0)
        yesBtn.layer.cornerRadius = 5
        yesBtn.layer.borderWidth = 1
        yesBtn.layer.borderColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0).cgColor
        //yesBtn.layer.borderColor = UIColor(red: 48/255, green: 123/255, blue: 246/255, alpha: 1.0).cgColor
        
        
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
