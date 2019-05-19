//
//  UserInfo.swift
//  SmartOrder
//
//  Created by Jeong on 17/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

struct UserInfo {
    var name: String
    var id: String
    var joinAddress: String
    //var orderList : OrderList
    //var likeList
    //var stampList
    //var couponList
    
    init(name: String?, id: String?, joinAddress: String?){
        self.name = name!
        self.id = id!
        self.joinAddress = joinAddress!
        
    }
    
    init(){
        self.name = ""
        self.id = ""
        self.joinAddress  = ""
    }
}
