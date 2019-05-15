//
//  MypageViewController.swift
//  SmartOrder
//
//  Created by Jeong on 05/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController {
   
    @IBOutlet weak var btnKakao: KKakaoLoginButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func kakaoAction(_ sender: Any) {
        btnKakao.actionSigninButton(view: self
            , completion: {(profile, error) -> Void in
                if(error != nil){
                    print("error : \(error!)")
                    return
                }
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                print ("####################################")
                
                
                guard profile != nil else {
                    print ("profile이 닐이다!!!!!")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    print("SUCCESS GET PROFILE!!\n")
                    if let email = profile?.account as? String{
                        print("Kakao email = \(email)")
                    }
                    if let nickName = profile!.nickname as? String{
                        print("Kakao Nick Name = \(nickName)")
                    }
                    // @property hasSignedUp
                    //* @abstract 현재 로그인한 사용자가 앱에 연결(signup)되어 있는지 여부
                    //* @discussion 사용자관리 설정에서 자동연결 옵션을 off한 앱에서만 사용되는 값입니다. 자동연결의 //기본값은 on이며 이 경우 값이 null로 반환되고 이미 연결되어 있음을 의미합니다.
                    if let hassignedUp = profile?.hasSignedUp{
                        print("Kakao hassignedup = \(hassignedUp.rawValue)")
                    }
                    if let iD = profile?.id as? String{
                        print("Kakao ID num = \(iD)")
                    }
                    if let profileImage = profile!.profileImageURL as? String{
                        print("Kakao Profile Image = \(profileImage)")
                    }
                    loginUserInfo = profile!
                    
                    ////응급조치!!!!!////
                    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
