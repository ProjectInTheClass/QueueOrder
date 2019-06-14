//
//  SettingsViewController.swift
//  SmartOrder
//
//  Created by Jeong on 13/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func soundBtn(_ sender: Any) {
        if let appURL = URL(string: "app-settings:root=Sounds&path=Ringtone://"){
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.openURL(appURL)
            }
            else {
                let alert = UIAlertController(title: " Error...", message:"could not found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default
                    , handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
//
//            let appName = "Settings"
//            let appScheme = "\(appName)://"
//            let appSchemeURL = URL(string: appScheme)
//            if UIApplication.shared.canOpenURL(appSchemeURL! as URL){ UIApplication.shared.open(appSchemeURL!, options: [:] , completionHandler: nil)
//            }
//            else {
//                let alert = UIAlertController(title: "\(appName) Error...", message:"could not found", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "ok", style: .default
//                    , handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
        }
    }
    
    @IBAction func askBtn(_ sender: Any) {
        let alert = UIAlertController(title: "문의메일", message:"hOrder@gmail.com", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default
            , handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pushBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
