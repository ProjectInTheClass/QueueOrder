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
    var couponindex: Int?
    
    //storyboard에서 직접적으로 할 일이 없으므로 바로 controller실행
    override func viewDidLoad() {
        super.viewDidLoad()
        print(items)
        goBuy()
    }
    //구매 API실행 controller로 이동
    func goBuy(){
        
        let today = NSDate()
        let dateformmater = DateFormatter()
        dateformmater.dateFormat = "yyyy년 M월 D일"
        
        vc = BootpayController()
       
        
        //이부분은 user정보 받는 부분 구현 후 삭제하고 userInfo를 따로 받을 예정입니다.
        //기본 struct는 name, email, phone, address인데 저흰 address가 필요 없으니
        //저 3가지만 저장하려 하는데 email이나 phone정보가 없어도 실행 가능한지 확인해 보겠습니다.
        
        var userInfo : [String: String] = [
            "name" : "최준호",
            "email" : "jeff0814@naver.com",
            "phone" : "010-9038-2047"
        ]
        //서버에서 다시 받는 값이라고 적혀있는데 잘 모르겠네요....
        let customParams: [String: String] = [
            "callbackParam1": "value12",
            "callbackParam2": "value34",
            "callbackParam3": "value56",
            "callbackParam4": "value78",
        ]
        //앞 controller에서 받은 menu들을 해당 API에 맞는 형태로
        //Parsing하는 과정
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
        //기본 정보 입력
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
        
        //쿠폰이 있는경우 적용
        if let index = couponindex{
            let selected = couponList.coupons[index]
            var price : Double
            if vc.price < Double(selected.price) {
                price = -vc.price
            }else{
                price = -Double(selected.price)
            }
            let item = BootpayItem()
            item.item_name = selected.name
            item.price = price
            item.qty = 1
            item.unique = String(selected.name.hashValue)
            vc.price += item.price
            vc.items.append(item)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension PayViewController : BootpayRequestProtocol{
    //error발생시 호출
    func onError(data: [String : Any]) {
        print(data)
    }
    //viewcontroller가 실행되기 전에 호출
    func onReady(data: [String : Any]) {
        print("ready")
        print(data)
    }
   //창을 닫을때 호출, 이전 화면(쿠폰 적용 화면)으로 돌아갑니다.
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
        //isValid를 설정해 두면 됩니다.
        
        var isValid = true
        if isValid{
            vc.transactionConfirm(data: data)
        }else{
            vc.removePaymentWindow()
        }
    }
    //취소 선택시 실행되는 함수
    func onCancel(data: [String : Any]) {
        print("cancel\n\(data)")
        vc.dismiss()
        self.navigationController?.popViewController(animated: true)
    }
    //결제 완료시 호출 되며 coupon을 사용한 경우
    //해당 쿠폰의 use를 설정해주고 첫 home화면으로 돌아갑니다.
    func onDone(data: [String : Any]) {
        print(data)
        if let index = couponindex{
            couponList.coupons[index].use = true
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
