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
    var item:String?
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destvc = segue.destination as! MenuTableViewController //Your ViewController class
        if let cell = sender as? UICollectionViewCell,
            let indexPath = caffeForView?.caffeInfo{
            let item = caffeList[indexPath]
            destvc.menuForView = item?.menu
            print("preview ...")
            print(item?.menu)
            print("preview 에서 넘기는 카페고유번호는 ...")
            destvc.cafeInfo = item?.caffeInfo
            print(item?.caffeInfo)
        }
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "coffe", sender: self)
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         let destvc = segue.destination as! MenuTableViewController //Your ViewController class
         let indexPath:Int? = caffeForView?.caffeInfo
         let item = caffeList[indexPath!] as! Caffe?
         //destvc.menuForView = item?.menu
         print("preview ...")
         //print(item?.menu)
         print("preview 에서 MenuTableViewController로 넘기는 카페고유번호는 ...")
         destvc.cafeInfo = (item?.caffeInfo)!
         print(destvc.cafeInfo)
        
    }
    
    @IBAction func noBtn(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func toBack(segue:UIStoryboardSegue) {
        
        if item == "back" {
            if let navController = self.navigationController {
               // navController.popViewController(animated: true)
                //navController.popToViewController( CaffeCollectionViewController, animated: true)
               
                let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: true)
            }
        }
    }
}
