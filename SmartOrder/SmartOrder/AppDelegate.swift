//
//  AppDelegate.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit
import SwiftyBootpay
import Firebase
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    public var mypageViewController: MypageViewController!
    var databaseRef: DatabaseReference!
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        BootpayAnalytics.sharedInstance.appLaunch(application_id: "59a4d328396fa607b9e75de6")
        
        //firebase
        FirebaseApp.configure()
        
        //google login
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //db정보 가져오기
        self.databaseRef = Database.database().reference()
 
        mypageViewController = UIStoryboard(name: "MyPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MypageVCID" ) as! MypageViewController
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        BootpayAnalytics.sharedInstance.sessionActive(active: false)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
        BootpayAnalytics.sharedInstance.sessionActive(active: true)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 델리게이트 지정시 노란색에 카카오화면 뜸. 눌렀을때의 액션은 아직.
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //카카오
        if KOSession.isKakaoAccountLoginCallback(url){
            return KOSession.handleOpen(url)
        }
        //구글
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
    
    // iOS 9.0 미만 버전에서는 아래 메서드 구현해야 한다.
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        //구글 로그인 시 사용하는 부분 입니다. 리턴은 Bool 형태로 구성되어 있어서, 단독 사용시 return 에 바로 입력하셔도 됩니다.
        let googleSession = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
        return googleSession
    }
    
    
    // 로그인 프로세스를 처리합니다.
    // 여기서는 로그인 시도 시 구현된 ViewController에서 실행하도록 하였습니다.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        //LoginController.sign(signIn!, didSignInFor: user, withError: error)
    }
    
    @nonobjc func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                         withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
        if let clintID = signIn.clientID {
            print("AppDelegate:signIn:clintID : \(clintID)")
        }
    }
    
    // 데이터베이스 참조 가져오기
    func getDatabaseRef() -> DatabaseReference! {
        guard databaseRef != nil else {
            return nil
        }
        
        return databaseRef
    }
    
    // 유저 등록
    func updateGoogleDB(uid: String?, userInfo: UserInfo){
        if let databaseRef =  getDatabaseRef() {
            let databaseRootChild = databaseRef.child("user_profiles").child(uid!)
            databaseRootChild.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapshot = snapshot.value as? NSDictionary
                
                if(snapshot == nil){
                    
                    databaseRootChild.child("name").setValue(userInfo.name)
                    databaseRootChild.child("id").setValue(userInfo.id)
                    databaseRootChild.child("join_address").setValue(userInfo.joinAddress)
                }
            })
        }
    }
    
    func addUserProfile(uid: String?, userInfo: UserInfo){
        //ID 존재여부 체크
        if let databaseRef =  getDatabaseRef() {
            
            let targetId = userInfo.id
            let loginAddress = userInfo.joinAddress
            
            let databaseRootChild = databaseRef.child("user_profiles")
            databaseRootChild.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapshot = snapshot.value as? NSDictionary
                
                if(snapshot != nil){
                    
                    let existIds = snapshot?.allValues as! [NSDictionary]
                    for info in existIds{
                        if let joinAddress = info.value(forKey: "join_address") as? String{
                            if let id = info.value(forKey: "id") as? String{
                                if id == targetId && loginAddress == joinAddress{
                                    return
                                }
                            }
                        }
                    }
                }
                self.updateGoogleDB(uid: uid, userInfo: userInfo)
            })
        }
    }
}

