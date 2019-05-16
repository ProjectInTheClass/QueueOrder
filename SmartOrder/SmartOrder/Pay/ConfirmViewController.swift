//
//  ConfirmViewController.swift
//  SmartOrder
//
//  Created by Ing on 16/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeImage: UIImageView!
    
    var items : cart!
    var CouponSelected : (Int , Coupon)?
    var total : Int = 0
 
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.coupons.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath) as! ConfirmTableViewCell
        
        
        let selecteditem = couponList.coupons[indexPath.row]
       
        if let selected = CouponSelected{
            if selected.0 == indexPath.row{
                self.present(cell.cancelController, animated: true, completion:{
                    if cell.canceled{
                        print("쿠폰 사용이 취소되었습니다.")
                        self.total += selected.1.price
                        self.Total.text = "\(self.total)"
                        self.CouponSelected = nil
                        cell.canceled = false
                    }
                })
            } else{
                self.present(cell.confirmController, animated: true, completion:{
                    if cell.confirmed{
                        print("\(selected.1.name) 대신 \(selecteditem.name)이 사용됩니다.")
                        self.total += selected.1.price
                        self.total -= selecteditem.price
                        self.Total.text = "\(self.total)"
                        self.CouponSelected = (indexPath.row, selecteditem)
                        cell.confirmed = false
                    }
                })
            }
        }
        else{
            self.present(cell.confirmController, animated: true, completion:{
            if cell.confirmed{
                print("\(selecteditem.name)이 사용됩니다.")
                self.total -= selecteditem.price
                self.Total.text = "\(self.total)"
                self.CouponSelected = (indexPath.row, selecteditem)
                cell.confirmed = false
                }
            })
        }
        print(CouponSelected)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath) as! ConfirmTableViewCell
        
        cell.textLabel?.text = couponList.coupons[indexPath.row].name
        cell.detailTextLabel?.text = "\(couponList.coupons[indexPath.row].price)원"
       
        if(indexPath.row == 0){
            cell.imageView?.image = UIImage(named: "2000coupon")
        }else{
            cell.imageView?.image = UIImage(named: "freeCoupon")
        }
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafeImage.image = UIImage(named:(caffeList[items.selectedMenu[0].caffeInfo]!.logo)!)
        cafeName.text = caffeList[items.selectedMenu[0].caffeInfo]!.name

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for order in items.selectedMenu{
            total += order.price
        }
        Total.text = "\(total)"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let today = NSDate()
        let dateformmater = DateFormatter()
        dateformmater.dateFormat = "yyyy년 M월 D일"
        
        if let selected = CouponSelected?.1{
            let couponAsOrder : Order = Order(caffeInfo: items.selectedMenu[0].caffeInfo, coffee: selected.name, price: (0 - selected.price), count: 1, size: "small", ice: "small", shot: 0, orderDate:dateformmater.string(from: today as Date))
            items!.selectedMenu.append(couponAsOrder)
        }
        let destVC = segue.destination as! PayViewController
        destVC.items = items
    }
    
    
}
