//
//  HomeViewController.swift
//  SmartOrder
//
//  Created by 하영 on 03/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in })
        
        item1.layer.borderWidth = 3
        item1.layer.borderColor = UIColor.white.cgColor
        item1.layer.cornerRadius = 3
        item2.layer.borderWidth = 3
        item2.layer.borderColor = UIColor.white.cgColor
        item2.layer.cornerRadius = 3
        
        super.viewDidLoad()
       
       //navigation bar back 글씨 지우기
        self.navigationController?.navigationBar.topItem?.title = ""
        
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
