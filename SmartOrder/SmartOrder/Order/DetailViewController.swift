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
    var caffeInfo = 0 //카페 고유 번호 받아와야함 -> 추후 수정.
    
    let alertController = UIAlertController(title: "음료를 담으시겠습니까?", message:
        "", preferredStyle: .alert)
    
    var isLiked = false
    
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
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        alertController.addAction(UIAlertAction(title: "확인", style: .default)
        {
            UIAlertAction in
            /*
             let storyBoard = self.storyboard!
             let cartView = storyBoard.instantiateViewController(withIdentifier: "cartView") as! CartViewController
             cartView.delegate = self
             
             self.present(cartView, animated: true, completion: nil)
             */
            
            /*
            let storyboard: UIStoryboard = UIStoryboard(name: "Cart", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "MyCart") as! CartViewController
            self.present(nextView, animated: true, completion: nil)
            */
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
            
            let addCart = Order(caffeInfo: self.caffeInfo, coffee: coffeeName, price: cost!,
                                count: amount!, size: cofeeSize, ice: iceSize, shot: shotInt!, orderDate: "")
            myCart.selectedMenu.append(addCart)
        })
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dismissFunc), name: Notification.Name.NSExtensionHostWillResignActive, object: nil)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            
            if caffeList[caffeInfo] != nil {
                add = caffeList[caffeInfo]!.sizeUp
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
        let price = cp!
        let shotCnt = sc!
        
        let total = count * ((price + add) + (shotCnt * 500))
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
        
        if(isLiked) {
            likeBtn.setImage(UIImage(named: "Unlike"), for: UIControl.State.normal)
        } else {
            likeBtn.setImage(UIImage(named: "like"), for: UIControl.State.normal)
        }
        
        isLiked = !isLiked
    }
}
