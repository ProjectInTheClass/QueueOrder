//
//  MypageViewController.swift
//  SmartOrder
//
//  Created by Jeong on 05/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit
import Firebase

class MypageViewController: UIViewController {
   
    var ref : DatabaseReference!
    
    //@IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var btnKakao: KKakaoLoginButton!
    
    @IBAction func kakaoAction(_ sender: Any) {
        btnKakao.actionSigninButton(view: self
            , completion: {(profile, error) -> Void in
                if(error != nil){
                    print("error : \(error!)")
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    loginUserInfo = profile!
                    //userImage.image = UIImage(data: loginUserInfo.)
                    self.userNameLabel.text = loginUserInfo?.nickname
                    //self.userEmailLabel.text = loginUserInfo?.account?.email
                    
                    // firebase 서버 데이터 저장
                    self.ref = Database.database().reference()
                self.ref.child("users").child((loginUserInfo?.id)!).setValue(["username": loginUserInfo?.nickname])
                    
                //self.ref.child("users").child((loginUserInfo?.id)!).setValue(userOrdered.orders, andPriority: 1)
                })
                
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loginUserInfo = loginUserInfo{
            //userImage.image = UIImage(data: loginUserInfo.)
            userNameLabel.text = loginUserInfo.nickname
        }
        else{
            userNameLabel.text = "로그인이 필요합니다"
        }
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "NeedOrderedSegue" {
            
            guard let loginUserInfo = loginUserInfo else{
                self.performSegue(withIdentifier: "NoLoginSegue", sender: nil)
                return false
            }
            
            if userOrdered.orders.count == 0 {
                self.performSegue(withIdentifier: "NoOrderedSegue", sender: nil)
                return false
            }
        }
        return true
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
