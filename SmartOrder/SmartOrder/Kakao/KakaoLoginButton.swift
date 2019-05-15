//
//  KakaoLoginButton.swift
//  SmartOrder
//
//  Created by Jeong on 04/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import Foundation

class KKakaoLoginButton : KOLoginButton{
    
    /// 카카오 로그인 버튼 클릭 이벤트 처리
    /// - Detail : 카카오 로그인 버튼 클릭 시 profile 정보를 넘겨줍니다.
    /// - Parameters:
    ///   - view: 카카오 로그인 화면이 추가될 rootView
    ///   - handler: 카카오 로그인 후 넘어오는 정보
    //    func actionSigninButton(view: UIViewController, completion handler: @escaping KOSessionTaskUserMeCompletionHandler){
    //        let session : KOSession = KOSession.shared()
    //
    //        if session.isOpen(){
    //            session.close()
    //        }
    //
    //        session.presentingViewController = view
    //        session.open(completionHandler: { (error) in
    //            session.presentingViewController = nil;
    //            //, authType: KOAuthType.talk, nil
    //            // 카카오 로그인 화면에서 벋어날 시 호출.
    //            if error != nil {
    //                print("Kakao login Error Massage : \(error?.localizedDescription ?? "")")
    //            }else if session.isOpen(){
    //                KOSessionTask.userMeTask(completion: handler)
    //            }else{
    //                print("Kakao login Error Massage : isn't open")
    //            }
    //        })
    //    }
    
    
    /// 카카오 로그인 버튼 클릭 시 사용자 정보 호출
    ///
    /// - Parameters:
    ///   - view: 카카오 버튼 표시할 View
    ///   - handler: 카카오 정보 가져왔을 시 이벤트 핸들러
    func actionSigninButton(view: UIViewController, completion handler: @escaping (_ result: KOUserMe?, _ error: Error?)->()){
        print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************") 
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
                print ("**************SigninButton***************")
        
        let session : KOSession = KOSession.shared()
        
        if session.isOpen(){
            session.close()
        }
        
        print ("A")
        session.presentingViewController = view
        session.open(completionHandler: { (error) in
            session.presentingViewController = nil;
            print ("B")
            // 카카오 로그인 화면에서 벋어날 시 호출.
            if error != nil {
                print("Kakao login Error Massage : \(error?.localizedDescription ?? "")")
            }else if session.isOpen(){
                /*
                KOSessionTask.userMeTask(completion: { (error, me) in
                    if let error = error as NSError? {
                        //UIAlertController.showMessage(error.description)
                    } else if let me = me as KOUserMe? {
                        print("id: \(String(describing: me.id))")
                    } else {
                        print("has no id")
                    }
                })*/
                
               KOSessionTask.userMeTask(completion: { (error, profile) in
                print ("C")
                    let info: KOUserMe? = profile as? KOUserMe
                
                    if  info == nil {
                        handler(nil, error)
                                        print ("info가 닐이다!!!!")
                        return
                    }
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        handler(info, nil)
                    })
                })
            }else{
                print("Kakao login Error Massage : isn't open")
            }
        })
    }
}
