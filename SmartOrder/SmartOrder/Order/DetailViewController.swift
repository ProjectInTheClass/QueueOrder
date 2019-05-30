//
//  DetailViewController.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
  
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var ifLarge: UILabel!
    @IBOutlet weak var sizeOption: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var coffeeSize: UISegmentedControl!
    @IBOutlet weak var coffee: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var shot: UILabel!
    @IBOutlet weak var resultPrice: UILabel!
    @IBOutlet weak var shotTit: UILabel!
    @IBOutlet weak var shotIncrease: UIButton!
    @IBOutlet weak var shotDecrease: UIButton!
    
    
    var coffeeForView:Menu?
    var caffeInfo:Int? //카페 고유 번호
    var coffeeNum:Int?
    
    let alertController = UIAlertController(title: "음료를 담으시겠습니까?", message:
        "", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ifLarge.isHidden = true
        
        //샷 추가 가능하지 않으면 보이지 않게
        if coffeeForView?.shot == false {
            shot.isHidden = true
            shotDecrease.isHidden = true
            shotTit.isHidden = true
            shotIncrease.isHidden = true
        }
        
        let str:Int! = coffeeForView?.price
        
        coffee?.image = UIImage(named: "coffee_picture_blue")
        coffeeName.text = coffeeForView?.coffee
        price.text = "\(str!) 원"
        resultPrice.text = "\(str!)"
        shotTit.text = "샷 추가(+ \(caffeList[caffeInfo!]!.shotPrice)원)"
        alertController.addAction(UIAlertAction(title: "취소", style: .destructive))
        alertController.addAction(UIAlertAction(title: "확인", style: .default)
        {
            UIAlertAction in
            
            if myCart.selectedMenu.count > 0 && myCart.selectedMenu[0].caffeInfo != self.caffeInfo {
                let confirmAlert = UIAlertController(title: "음료를 담을 수 없습니다.", message: "장바구니에 다른 카페의 음료가 있습니다.", preferredStyle: .alert)
                self.present(confirmAlert, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    confirmAlert.dismiss(animated: true, completion: nil)
                }
            } else {
                var coffeeName = ""
                if let coffee = self.coffeeForView?.coffee {
                    coffeeName = coffee
                }
                
                var cost:Int? = 0
                if let res = self.resultPrice?.text {
                    cost = Int(res)
                }
                
                var coffeePrice:Int = 0
                if let cp = self.coffeeForView?.price {
                    coffeePrice = cp
                }
                
                var amount:Int? = 0
                if let am = self.amount?.text {
                    amount = Int(am)
                }
                
                var cofeeSize = "Small"
                if let sz = self.coffeeSize.titleForSegment(at: self.coffeeSize.selectedSegmentIndex) {
                    cofeeSize = sz
                }
                var iceSize = "보통"
                if let ice = self.ice.titleForSegment(at: self.ice.selectedSegmentIndex) {
                    iceSize = ice
                }
                
                var shotInt:Int? = 0
                if let sht = self.shot?.text {
                    shotInt = Int(sht)
                }
                
                let addCart = Order(caffeInfo: self.caffeInfo!, coffee: coffeeName, price: cost!,
                                    count: amount!, size: cofeeSize, ice: iceSize, shot: shotInt!, orderDate: "")
                myCart.selectedMenu.append(addCart)
                cartSelectedArray.append(1)
                
                let confirmAlert = UIAlertController(title: "", message: "음료가 담겼습니다.", preferredStyle: .alert)
                self.present(confirmAlert, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    confirmAlert.dismiss(animated: true, completion: nil)
                }
            }
        })
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dismissFunc), name: Notification.Name.NSExtensionHostWillResignActive, object: nil)
       
        if coffeeForView!.isLiked {
            likeBtn.setImage(UIImage(named: "like" ), for: UIControl.State.normal)
        } else {
            print("선호메뉴가 아님")
            print(coffeeForView?.coffee)
            likeBtn.setImage(UIImage(named: "Unlike"), for: UIControl.State.normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("넘겨받은 고유번호")
        print(caffeInfo)
        print(coffeeForView?.coffee)
        
    }
    
    // 총 결제 금액 계산하는 함수
    func calculation () {
        var num:Int? = nil
        
        var cp:Int? = nil
        
        if let str = amount.text {
            num = Int(str)
        }
        
        if let coffeePrice = coffeeForView?.price {
            cp = Int(coffeePrice)
        }

        var sc:Int? = nil
        if let tmp = shot.text {
            sc = Int(tmp)
        }
        
        var add:Int = 0
        
        if sizeOption.selectedSegmentIndex == 1 {
            price.isHidden = true
            ifLarge.isHidden = false
            
            if caffeList[caffeInfo!] != nil {
                add = caffeList[caffeInfo!]!.sizeUp
            } else {
                add = 600
            }
            
            ifLarge.text = "\(cp! + add) 원"
        }
        else {
            ifLarge.isHidden = true
            price.isHidden = false
        }
        let count = num!
        let Lprice = cp!
        let shotCnt = sc!
        let shotAddPrice = caffeList[caffeInfo!]!.shotPrice
        let total = count * ((Lprice + add) + (shotCnt * shotAddPrice))
        resultPrice.text = "\(total)"
    }
    
    @IBAction func amountMinus(_ sender: Any) {
        if amount.text != "1" {
            var num:Int? = nil
          
            if let str = amount.text {
                num = Int(str)
            }
            
            if let amountNum = num {
                amount.text = "\(amountNum-1)"
            }
            calculation()
        }
    }
    
    @IBAction func amountPlus(_ sender: Any) {
        var num:Int? = nil
        
        if let str = amount.text {
            num = Int(str)
        }
        
        if let amountNum = num {
            amount.text = "\(amountNum+1)"
        }
        
        calculation()
    }
    
    @IBAction func shotMinus(_ sender: Any) {
        let str = shot.text
        let sc = Int(str!)
        
        if shot.text != "0" {
            shot.text = "\(sc!-1)"
            calculation()
        }
    }
    @IBAction func shotPlus(_ sender: Any) {
        let str = shot.text
        let sc = Int(str!)
        
        shot.text = "\(sc!+1)"
        calculation()
        
    }
    @IBAction func showAlert(_ sender: Any) {
        self.present(alertController, animated: true, completion: {
            print("장바구니에 추가한 item 갯수는... \(myCart.selectedMenu.count)")
        })
    }
    
    @objc func dismissFunc(){
        self.alertController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedSize(_ sender: Any) {
        calculation()
    }
    @IBAction func onClikLikeBtn(_ sender: Any) {
        while MyMenu.count-1 < caffeInfo!{
            MyMenu.append([])
        }
        print(coffeeForView!.isLiked)
        
        var liked:Bool?
        if let tmpLike = caffeList[caffeInfo!]?.menu[coffeeForView!.menuId]?.isLiked { caffeList[caffeInfo!]?.menu[coffeeForView!.menuId]?.isLiked = !tmpLike
            liked = !tmpLike
        }
        //coffeeForView!.isLiked = !coffeeForView!.isLiked
   
        if(!liked!) {
            likeBtn.setImage(UIImage(named: "Unlike"), for: UIControl.State.normal)
            MyMenu[caffeInfo!] = MyMenu[caffeInfo!].filter({$0.coffee != coffeeForView?.coffee})
        } else {
            likeBtn.setImage(UIImage(named: "like"), for: UIControl.State.normal)
            //MyMenu[caffeInfo!].append(coffeeForView!)
            MyMenu[caffeInfo!].append((caffeList[caffeInfo!]?.menu[coffeeForView!.menuId])!)
        }
        
        print("선호메뉴")
        print(MyMenu)
        
        /* 주석 부탁드립니다.
        MenuSubscript = MenuSubscript.map({x -> Menu in
            if x.coffee == coffeeForView!.coffee{
                return coffeeForView!
            }
            else { return x }
        })
        */
      
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "Payment"{
            var Ice_size : String
            if let isz = ice.titleForSegment(at: self.ice.selectedSegmentIndex){
                Ice_size = isz
            }
            else{
                Ice_size = "보통"
            }
            var Drink_size : String
            if let dsz = coffeeSize.titleForSegment(at: self.coffeeSize.selectedSegmentIndex){
                Drink_size = dsz
            }
            else {
                Drink_size = "small"
            }
            let Today = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월 d일"
            let new_order : Order = Order(caffeInfo : caffeInfo!, coffee : coffeeName.text!, price:
                Int(resultPrice.text!)!, count: Int(amount.text!)!, size: Drink_size, ice: Ice_size, shot: Int(shot.text!)!, orderDate: dateFormatter.string(from : Today as Date))
            let one_Order : cart = cart(selectedMenu : [new_order])
           
            
            let destVC = segue.destination as! ConfirmViewController
            destVC.items = one_Order
            
        }
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
