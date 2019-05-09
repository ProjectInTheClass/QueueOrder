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
    
    let alertController = UIAlertController(title: "장바구니로 이동하시겠습니까?", message:
        "음료가 등록되었습니다.", preferredStyle: .alert)
    
  
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var coffeeSize: UISegmentedControl!
    @IBOutlet weak var coffee: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var shot: UILabel!
    @IBOutlet weak var resultPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str:Int! = coffeeForView?.price
        
        coffee?.image = UIImage(named: "coffee_picture_blue")
        coffeeName.text = coffeeForView?.coffee
        price.text = "\(str!) 원"
        resultPrice.text = "\(str!)"
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
       // alertController.addAction(UIAlertAction(title: "확인", style: .default))
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
            
            var addCart = Order(caffeInfo: self.caffeInfo, coffee: coffeeName, price: cost!,
                                count: amount!, size: cofeeSize, ice: iceSize, shot: shotInt!, orderDate: "")
            myCart.selectedMenu.append(addCart)
        })
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dismissFunc), name: Notification.Name.NSExtensionHostWillResignActive, object: nil)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(coffeeForView?.coffee)
        
    }
    @IBAction func amountMinus(_ sender: Any) {
        
        var num:Int? = nil
        let rp = Int(resultPrice.text!)
        //let cp = Int(coffeeForView!.price)
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
            if let sumPrice:Int = rp, let price:Int = cp{
                let res = sumPrice-price
                resultPrice.text = "\(res)"
            }
        }
    }
    
    @IBAction func amountPlus(_ sender: Any) {
        //let str = amount.text
        //let num = Int(str!)
        var num:Int? = nil
        let rp = Int(resultPrice.text!)
        //let cp = Int(coffeeForView!.price)
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
        
        //resultPrice.text = "\(rp! + cp)"
        if let sumPrice:Int = rp, let price:Int = cp{
            let res = sumPrice+price
            resultPrice.text = "\(res)"
        }
        
    }
    @IBAction func shotMinus(_ sender: Any) {
        let str = shot.text
        let num = Int(str!)
        let rp = Int(resultPrice.text!)
        
        let amt = amount.text
        
        if shot.text != "0" {
            shot.text = "\(num!-1)"
            resultPrice.text = "\(rp!-500*(Int(amt!)!))"
        }
    }
    @IBAction func shotPlus(_ sender: Any) {
        let str = shot.text
        let num = Int(str!)
        let rp = Int(resultPrice.text!)
        
        let amt = amount.text
        
        shot.text = "\(num!+1)"
        resultPrice.text = "\(rp!+500*(Int(amt!)!))"
        
    }
    @IBAction func showAlert(_ sender: Any) {
        self.present(alertController, animated: true, completion: {
             print("장바구니에 있는 item 갯수는... \(myCart.selectedMenu.count)")
        })
    }
    
    @objc func dismissFunc(){
        self.alertController.dismiss(animated: true, completion: nil)
    }
}
