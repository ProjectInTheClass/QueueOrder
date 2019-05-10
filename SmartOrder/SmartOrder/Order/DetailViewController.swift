//
//  DetailViewController.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var coffeeForView:Menu?
    var caffeInfo = 0 //카페 고유 번호 받아와야함 -> 추후 수정.
    
    let alertController = UIAlertController(title: "음료를 담으시겠습니까?", message:
        "", preferredStyle: .alert)
    
  
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func calculation (count:Int, price:Int, shotCnt:Int) {
        let total = count * (price + (shotCnt * 500))
        resultPrice.text = "\(total)"
    }
    
    @IBAction func amountMinus(_ sender: Any) {
        
        var num:Int? = nil
        
        var cp:Int? = nil
        
        if let str = amount.text {
            num = Int(str)
        }
        
        if let coffeePrice = coffeeForView?.price {
            cp = Int(coffeePrice)
        }
        
        if amount.text != "1" {
            if let amountNum = num {
                amount.text = "\(amountNum-1)"
            }
            //총액 계산
            
            var sc:Int? = nil
            if let tmp = shot.text {
                sc = Int(tmp)
            }
            
            calculation(count:num!-1, price:cp!, shotCnt:sc!)
        }
    }
    
    @IBAction func amountPlus(_ sender: Any) {
        
        var num:Int? = nil
        
        var cp:Int? = nil
        if let str = amount.text {
            num = Int(str)
        }
        
        if let coffeePrice = coffeeForView?.price {
            cp = Int(coffeePrice)
        }
        
        if let amountNum = num {
            amount.text = "\(amountNum+1)"
        }
        
        //총액 계산
        
        var sc:Int? = nil
        if let tmp = shot.text {
            sc = Int(tmp)
        }
        calculation(count:num!+1, price:cp!, shotCnt:sc!)
        
    }
    @IBAction func shotMinus(_ sender: Any) {
        let str = shot.text
        let sc = Int(str!)
        
        if shot.text != "0" {
            shot.text = "\(sc!-1)"
            
            //총액 계산
            var cp:Int? = nil
            var num:Int? = nil
            if let str = amount.text {
                num = Int(str)
            }
            
            if let coffeePrice = coffeeForView?.price {
                cp = Int(coffeePrice)
            }
            calculation(count:num!, price:cp!, shotCnt:sc!-1)
        }
    }
    @IBAction func shotPlus(_ sender: Any) {
        let str = shot.text
        let sc = Int(str!)
        
        shot.text = "\(sc!+1)"
        //총액 계산
        
        var cp:Int? = nil
        var num:Int? = nil
        if let str = amount.text {
            num = Int(str)
        }
        
        if let coffeePrice = coffeeForView?.price {
            cp = Int(coffeePrice)
        }
        calculation(count:num!, price:cp!, shotCnt:sc!+1)
        
    }
    @IBAction func showAlert(_ sender: Any) {
        self.present(alertController, animated: true, completion: {
            print("장바구니에 추가한 item 갯수는... \(myCart.selectedMenu.count)")
        })
    }
    
    @objc func dismissFunc(){
        self.alertController.dismiss(animated: true, completion: nil)
    }
}
