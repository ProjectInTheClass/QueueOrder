//
//  LoginViewController.swift
//  SmartOrder
//
//  Created by Jeong on 04/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var btnKakao: KKakaoLoginButton!
    
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
                    print("READY FOR KAKAO PROFILE!!\n")
                    
                    loginUserInfo = profile!
                    print("loginUserInfo nickname = \(loginUserInfo?.nickname)")
                    
                    ////응급조치!!!!!////
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                })
                
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //true 반환시 세그웨이 동작
    // 조건 = 변수가 변경되면, 변수에 didSet을 이용해서 변경되는 값을 검사해서 씬 이동하도록 작성.
    /*
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "NeedLoginSegue" {
            if checkUserInformation(userDefaults)==false {
                self.performSegueWithIdentifier("LoginSegue", sender: nil)
            }
            return false
        }
        return true
    }*/

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        if "Home" == identifier {
            
        }
        if let loginUserInfo = loginUserInfo as? KOUserMe {
            self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            print("TRUE")
            return true;
        }
        else{
            print("FALSE")
            return false;
        }
    }
    
}
