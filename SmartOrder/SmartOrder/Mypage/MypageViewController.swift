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
    var imagepicked = UIImage(named:"coffeebottlefilled")
    @IBOutlet weak var loginIcon: UIImageView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var logoutIcon: UIImageView!
    let alertController = UIAlertController(title: "로그인이 필요한 항목입니다.", message:
        "", preferredStyle: .alert)
    let logoutalertController = UIAlertController(title: "로그아웃 하시겠습니까?", message:
        "", preferredStyle: .alert)
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var joinAddress: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var orderInfoButton: UIButton!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert =  UIAlertController(title: "사진 선택", message: "원하는 저장소를 선택해주세요.", preferredStyle: .alert)
        
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            
            self.openLibrary()
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            
            self.openCamera()
            
        }
        
        let defaultimage =  UIAlertAction(title: "기본이미지", style: .default) { (action) in
            self.mainImage.image = UIImage(named: "coffeebottlefilled")
            self.mainImage.contentMode = .scaleAspectFit
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(defaultimage)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 주문내역 alert처리.
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        alertController.addAction(UIAlertAction(title: "로그인", style: .default)
            {UIAlertAction in
            self.performSegue(withIdentifier: "LoginVCSegue", sender: nil)
            })
        self.mainImage.layer.cornerRadius = self.mainImage.frame.size.height / 2
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
    
    /// - Returns: AppDelegate
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
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
        addButton.isHidden = false
        mainImage.image = imagepicked
    }
    
    // 처음에 보여줄 뷰 결정하기
    func setDefault(){
        // 처음에 로그인 전에 이름값 숨겨주기
        userNameLabel.text = "회원서비스 이용을 위해 로그인해주세요."
        joinAddress.text = "안녕하세요!"
        
        //버튼 디자인 요소 추가
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        
        authenticationUser()
    }
}

extension MypageViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    private func presentImagePickerController(withSourceType sourceType: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imagepicked = image
            mainImage.image = image
            mainImage.contentMode = .scaleAspectFill
            
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func openLibrary(){
        presentImagePickerController(withSourceType: .photoLibrary)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            presentImagePickerController(withSourceType: .camera)
        }
        else{
            
            print("Camera not available")
            
        }
    }
}
