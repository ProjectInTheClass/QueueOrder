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
        
        for menu in items.selectedMenu{
            let item = BootpayItem()
            item.item_name = menu.coffee
            item.price = Double(menu.price)
            item.qty = menu.count
            item.unique = String(menu.coffee.hashValue)
            if menu.size != "Small"{
                item.item_name += " 사이즈 업"
            }
            if menu.shot != 0{
                item.item_name += " 샷 \(menu.shot)추가"
            }
            vc.price += item.price
            vc.items.append(item)
        }
        
        vc.params{
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func onConfirm(data: [String : Any]) {
        print(data)
        
        //이 부분은 후에 서버 구축 후 카페에서
        //주문을 받을 수 있는 상태인지 아닌지에 따라
        //주문을 가능하게 할지, 아닌지를 결정 할 수
        //있도록 하여 후에 서버의 답변에 따라
        //isValid를 설정해 두면 된다.
        
        var isValid = true
        if isValid{
            vc.transactionConfirm(data: data)
        }else{
            vc.removePaymentWindow()
        }
    }
    
    func onCancel(data: [String : Any]) {
        print("cancel\n\(data)")
    }
    
    func onDone(data: [String : Any]) {
        print(data)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
