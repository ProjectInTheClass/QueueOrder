//
//  SignUpController.swift
//  SmartOrder
//
//  Created by Jeong on 23/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

protocol SignUpDelegate {
    func signupCompleted()
}

class SignUpController: UIViewController, GIDSignInUIDelegate {
    
    var delegate: SignUpDelegate?
    
    // MARK: - Properties
    let alertController = UIAlertController(title: "형식이 올바르지 않습니다.\n 이메일 형식, 비밀번호 6자리 이상", message:
        "", preferredStyle: .alert)
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "coffee_picture")
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), emailTextField)
    }()
    
    lazy var usernameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "ic_person_outline_white_2x"), usernameTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "ic_lock_outline_white_2x"), passwordTextField)
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Email", isSecureTextEntry: false)
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Username", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true)
    }()
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원 가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBrown(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var dividerView: UIView = {
        let dividerView = UIView()
        
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor(white: 1, alpha: 0.88)
        label.font = UIFont.systemFont(ofSize: 14)
        dividerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor).isActive = true
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor(white: 1, alpha: 0.88)
        dividerView.addSubview(separator1)
        separator1.anchor(top: nil, left: dividerView.leftAnchor, bottom: nil, right: label.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
        separator1.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        
        let separator2 = UIView()
        separator2.backgroundColor = UIColor(white: 1, alpha: 0.88)
        dividerView.addSubview(separator2)
        separator2.anchor(top: nil, left: label.rightAnchor, bottom: nil, right: dividerView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
        separator2.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        
        return dividerView
    }()
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.setTitle("구글 계정으로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .googleRed()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return button
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.setTitle("카카오 계정으로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        //button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "이미 계정이 있으신가요?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "로그인 하기", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
    }
    
    // MARK: - Selectors
    
    @objc func handleGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        createUser(withEmail: email, password: password, username: username)
    }
    
    @objc func handleShowLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func createUser(withEmail email: String, password: String, username: String) {

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                self.present(self.alertController, animated: true, completion: {})
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "username": username]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values with error: ", error.localizedDescription)
                    return
                }
                
                print ("successful signup")
                
                print ("successful signup")
                
                print ("successful signup")
                
                print ("successful signup")
                
                print ("successful signup")
//                self.dismiss(animated: true, completion: {
                self.dismiss(animated: true, completion: nil)
                self.delegate?.signupCompleted()
//                })
                /*
                guard let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
                guard let controller = navController.viewControllers[0] as? HomeController else { return }
                controller.configureViewComponents()
                
                // forgot to add this in video
                controller.loadUserData()
                
                self.dismiss(animated: true, completion: nil)*/
            })
            
        }
        
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBrown()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(usernameContainerView)
        usernameContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: usernameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
//        view.addSubview(dividerView)
//        dividerView.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
//
//        view.addSubview(googleLoginButton)
//        googleLoginButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
//
//        view.addSubview(kakaoLoginButton)
//        kakaoLoginButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 30, paddingRight: 32, width: 0, height: 50)
        
    }
}
