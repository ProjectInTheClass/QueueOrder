//
//  PayViewController.swift
//  SmartOrder
//
//  Created by 준호on 2019. 5. 9..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit
import SwiftyBootpay

class PayViewController: UIViewController {
    
    var vc : BootpayController!
    var items : cart!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBuy()
        // Do any additional setup after loading the view.
    }
    
    func goBuy(){
        vc = BootpayController()
        
        items = cart(selectedMenu: [order1])
        items.selectedMenu.append(order2)
        
        var userInfo : [String: String] = [
            "name" : "최준호",
            "email" : "jeff0814@naver.com",
            "phone" : "010-9038-2047"
        ]
        let customParams: [String: String] = [
            "callbackParam1": "value12",
            "callbackParam2": "value34",
            "callbackParam3": "value56",
            "callbackParam4": "value78",
            ]
        
        vc.params{
            $0.price = 0
            $0.name = "Cafe Queue"
            $0.pg = "kakao"
            $0.phone = userInfo["phone"]!
            $0.method = "easy"
            $0.params = customParams
            $0.sendable = self as BootpayRequestProtocol
            $0.user_info = userInfo
            $0.order_id = "1234"
            $0.quotas = [0];
            
        }
        for menu in items.selectedMenu{
            let item = BootpayItem()
            item.item_name = menu.coffee
            item.price = Double(menu.price)
            item.qty = menu.count
            item.unique = String(menu.coffee.hashValue)
            vc.price += item.price
            vc.items.append(item)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension PayViewController : BootpayRequestProtocol{
    func onError(data: [String : Any]) {
        print(data)
    }
    
    func onReady(data: [String : Any]) {
        print("ready")
        print(data)
    }
    
    func onClose() {
        print("close")
        vc.dismiss()
    }
    
    func onConfirm(data: [String : Any]) {
        print(data)
        
        var isValid = true
        if isValid{
            vc.transactionConfirm(data: data)
        }else{
            vc.removePaymentWindow()
        }
    }
    
    func onCancel(data: [String : Any]) {
        print(data)
    }
    
    func onDone(data: [String : Any]) {
        print(data)
    }
    
}
