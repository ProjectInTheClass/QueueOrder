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
    
   // var ref : DatabaseReference!
    
    @IBOutlet weak var btnKakao: KKakaoLoginButton!
    
    @IBOutlet weak var btnGoogle: GIDSignInButton!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var joinAddress: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
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
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    guard (self.getAppDelegate()) != nil else{
                        return
                    }
                    //Google DB Update
                    var info = UserInfo()
                    info.joinAddress = "kakao"
                    
                    if let nickName = profile!.nickname{
                        print("kakao nickname : \(nickName)")
                        info.name = "\(nickName)"
                    }
                    
                    if let value = profile!.id{
                        print("kakao id : \(value)\r\n")
                        info.id =  "\(value)"
                    }
                    
                    
                    loginUserInfo = profile!
                    
                    let appDelegate = self.getAppDelegate()
                    appDelegate?.addUserProfile(uid: appDelegate?.getDatabaseRef().childByAutoId().key, userInfo: info)
                    
                    // firebase에 저장된 데이터 받아오기
                    //let userID = Auth.auth().currentUser?.uid
                    let userID = loginUserInfo?.id
                    appDelegate?.databaseRef.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
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
                        self.userImage.image = UIImage(named : "Kakao")
                        self.joinAddress.text = "Kakao"
                        self.joinAddress.isHidden = false
                        self.userNameLabel.isHidden = false
                        self.label1.isHidden = true
                        self.label2.isHidden = true
                        self.label3.isHidden = true
                        //self.userEmailLabel.isHidden = false
                        currentUserInfo.id = loginUserInfo.id!
                    }
                })
                
        })
    }
    func setUserInfo() {
        if let loginUserInfo = loginUserInfo{
            //userImage.image = UIImage(data: loginUserInfo.)
            self.userNameLabel.text = loginUserInfo.nickname
            self.userImage.image = UIImage(named : "Kakao")
            self.joinAddress.text = "Kakao"
            self.joinAddress.isHidden = false
            
            //self.userEmailLabel.isHidden = false
            currentUserInfo.id = loginUserInfo.id!
        } else{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("ViewDidLoad")
        // Google Signin버튼
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // 주문내역 alert처리.
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        
        userNameLabel.isHidden = true
        joinAddress.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // userInfo 초기화
        print ("viewDidAppear")
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
    
    /// AppDelegate 가져오기
    ///
    /// - Returns: AppDelegate
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /// 구글 로그인 정보 가져옵니다.
    ///
    /// - Parameters:
    ///   - signIn: SignIn 된 정보를 가져옵니다
    ///   - user: 구글 로그인 정보를 가져옵니다
    ///   - error: 에러 메시지를 가져옵니다
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

        
        if let err = error {
            print("LoginViewController:error = \(err)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if let err = error {
                print("LoginViewController:error = \(err)")
                return
            }
            
            
            if let appDelegate = self.getAppDelegate(){
                
                let info = UserInfo(name: user?.user.displayName, id: user?.user.providerID, joinAddress: "google")
                
                appDelegate.addUserProfile(uid: (user?.user.uid)!, userInfo: info)
            }
        }
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
