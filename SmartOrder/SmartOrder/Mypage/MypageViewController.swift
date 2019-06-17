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

class MypageViewController: UIViewController, GIDSignInUIDelegate
    {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var loginIcon: UIImageView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var logoutIcon: UIImageView!
    let alertController = UIAlertController(title: "로그인이 필요한 항목입니다.", message:
        "", preferredStyle: .alert)
    let logoutalertController = UIAlertController(title: "로그아웃 하시겠습니까?", message:
        "", preferredStyle: .alert)
    
    //@IBOutlet weak var btnKakao: KKakaoLoginButton!
    
    //@IBOutlet weak var btnGoogle: GIDSignInButton!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var joinAddress: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var orderInfoButton: UIButton!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
            
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            
            self.openCamera()
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    // 로그아웃 버튼 눌렀을때 동작 처리.
    @IBAction func pressLogout(_ sender: Any) {
        self.present(logoutalertController, animated: true, completion: {})
        authenticationUser()
    }
    
    // 주문내역 버튼 눌렀을때 동작 처리.
    @IBAction func pressOrderButton(_ sender: Any) {
        // 로그인 되어있지 않으면
        guard let currentUser = Auth.auth().currentUser else{
            //alert 발생 (취소, login)
            self.present(alertController, animated: true, completion: {})
            return
        }
        // 로그인 되어있으면 (NeedOrderSegue를 통해 테이블뷰로 이동)
        if (currentUserInfo.orderList.count == 0){
            self.performSegue(withIdentifier: "NoOrderedSegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "NeedOrderedSegue", sender: nil)
        }
    }
    /*
    // 카카오 버튼 눌렀을때 동작 처리
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
                        self.label2.isHidden = true
                        //self.userEmailLabel.isHidden = false
                        currentUserInfo.id = loginUserInfo.id!
                    }
                })
                
        })
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Google Signin버튼
        //GIDSignIn.sharedInstance().uiDelegate = self
        
        // 주문내역 alert처리.
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        alertController.addAction(UIAlertAction(title: "로그인", style: .default)
            {UIAlertAction in
            self.performSegue(withIdentifier: "LoginVCSegue", sender: nil)
            })
        
        // 로그아웃 alert처리
        logoutalertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        logoutalertController.addAction(UIAlertAction(title: "확인", style: .default){
            UIAlertAction in
            do{
            try Auth.auth().signOut()
                self.authenticationUser()
            } catch let error {
                print("fail to signout")
            }
            })
        
        setDefault()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print ("ViewWillAppear")
        authenticationUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//    // 세그웨이 실행전 조건 확인.
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        print("shouldPerformSegue")
//        if identifier == "NeedOrderedSegue" {
//            if currentUserInfo.orderList.orders.count == 0 {
//
//
//                self.performSegue(withIdentifier: "NoOrderedSegue", sender: nil)
//                return false
//            }
//        }
//        return true
//    }
    
    /// AppDelegate 가져오기
    ///
    /// - Returns: AppDelegate
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
//    /// 구글 로그인 정보 가져옵니다.
//    ///
//    /// - Parameters:
//    ///   - signIn: SignIn 된 정보를 가져옵니다
//    ///   - user: 구글 로그인 정보를 가져옵니다
//    ///   - error: 에러 메시지를 가져옵니다
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//
//
//        if let err = error {
//            print("LoginViewController:error = \(err)")
//            return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signIn(with: credential) { (user, error) in
//            // ...
//            if let err = error {
//                print("LoginViewController:error = \(err)")
//                return
//            }
//
//
//            if let appDelegate = self.getAppDelegate(){
//
//                let info = UserInfo(name: user?.user.displayName, id: user?.user.providerID, joinAddress: "google")
//
//                appDelegate.addUserProfile(uid: (user?.user.uid)!, userInfo: info)
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func openLibrary(){
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            picker.sourceType = .camera
            
            present(picker, animated: false, completion: nil)
            
        }
        else{
            
            print("Camera not available")
            
        }
    }
    
    // 인증 조건에 맞춰서 뷰 변화주기
    func authenticationUser(){
        guard let currentUser = Auth.auth().currentUser else{
            loginButton.isHidden = false
            logoutIcon.isHidden = true
            loginButtonLabel.text = "로그인"
            loginIcon.isHidden = false;
            logoutButton.isHidden = true
            label2.isHidden = false
           addButton.isHidden = true
            userNameLabel.text = "회원서비스 이용을 위해 로그인해주세요."
            joinAddress.text = "안녕하세요!"
            mainImage.image = UIImage(named: "coffeebottle2")
            return
        }
        loginButton.isHidden = true
        logoutIcon.isHidden = false
        loginButtonLabel.text = "로그아웃"
        loginIcon.isHidden = true;
        logoutButton.isHidden = false
        label2.isHidden = true
        userNameLabel.text = "님 안녕하세요!"
        joinAddress.text = Auth.auth().currentUser?.email
        mainImage.image = UIImage(named: "coffeebottlefilled")
        addButton.isHidden = false
    }
    
    // 처음에 보여줄 뷰 결정하기
    func setDefault(){
        // 처음에 로그인 전에 이름값 숨겨주기
        userNameLabel.text = "회원서비스 이용을 위해 로그인해주세요."
        joinAddress.text = "안녕하세요!"
        
        //버튼 디자인 요소 추가
        //loginButton.setTitle("  로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        //loginButton.layer.cornerRadius = 5
        //orderInfoButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        //logoutButton.setTitle("  로그아웃", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        //logoutButton.layer.cornerRadius = 5
        
        authenticationUser()
    }
}

extension MypageViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            mainImage.image = image
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}
