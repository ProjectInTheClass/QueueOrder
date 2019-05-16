//
//  MypageViewController.swift
//  SmartOrder
//
//  Created by Jeong on 05/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MypageViewController: UIViewController, GIDSignInUIDelegate {
    
    let alertController = UIAlertController(title: "로그인이 필요한 항목입니다", message:
        "", preferredStyle: .alert)
    
    var ref : DatabaseReference!
    
    @IBOutlet weak var btnKakao: KKakaoLoginButton!
    
    @IBOutlet weak var btnGoogle: GIDSignInButton!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func alertAction(_ sender: Any) {
        guard let loginUserInfo = loginUserInfo else{
            self.present(alertController, animated: true, completion: {})
            return
        }
        self.performSegue(withIdentifier: "NeedOrderedSegue", sender: nil)
    }
    
    @IBAction func kakaoAction(_ sender: Any) {
        btnKakao.actionSigninButton(view: self
            , completion: {(profile, error) -> Void in
                if(error != nil){
                    print("error : \(error!)")
                    return
                }
                
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
                    
                    // firebase 서버 데이터 저장
                    self.ref = Database.database().reference()
                    self.ref.child("users").child((loginUserInfo?.id)!).setValue(["username": loginUserInfo?.nickname])
                    
                    // firebase에 저장된 데이터 받아오기
                    //let userID = Auth.auth().currentUser?.uid
                    let userID = loginUserInfo?.id
                    self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        let username = value?["username"] as? String ?? ""
                        //let user = User(username: username)
                        print("value : \(value)")
                        print("username :" + username)
                        // ...
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    if let loginUserInfo = loginUserInfo{
                        //userImage.image = UIImage(data: loginUserInfo.)
                        self.userNameLabel.text = loginUserInfo.nickname
                    }
                })
                
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google Signin버튼
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // userInfo 초기화
        if let loginUserInfo = loginUserInfo{
            //userImage.image = UIImage(data: loginUserInfo.)
           // let data = Data(contentsOf: loginUserInfo.profileImageURL)
           // let profileimage = UIImage(data: data)
            //userImage.image = profileimage
            self.userNameLabel.text = loginUserInfo.nickname
        } else {
            self.userNameLabel.text = "로그인이 필요합니다"
        }
        
        
        // 주문내역 alert처리.
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print ("ViewWillAppear")
        /*
        if let loginUserInfo = loginUserInfo{
            //userImage.image = UIImage(data: loginUserInfo.)
            userNameLabel.text = loginUserInfo.nickname
        }
        else{
            userNameLabel.text = "로그인이 필요합니다"
        }*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "NeedOrderedSegue" {
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
