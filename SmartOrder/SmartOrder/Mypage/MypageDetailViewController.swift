//
//  MypageDetailViewController.swift
//  SmartOrder
//
//  Created by Jeong on 15/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageDetailViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderInfo!.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = test.dequeueReusableCell(withIdentifier: "OrderListDetailCell", for: indexPath) as? OrderListDetailTableViewCell
        
        let orderForTheRow:Order = orderInfo!.orders[indexPath.row]
        cell!.menuNameLabel.text = orderForTheRow.coffee
        cell!.menuImage.image = UIImage(named: "coffee_picture_blue")
        cell!.totalPriceLabel.text = "금액 \(orderForTheRow.price)원"
        cell!.totalCount.text = String(orderInfo!.orders.count)
        cell!.menuImage.image = UIImage(named: "coffee_picture_blue")
        cell!.sizeIceShot.text = "사이즈\(orderForTheRow.size) / 얼음\(orderForTheRow.ice) / 샷추가\(orderForTheRow.shot)"
//
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBOutlet weak var cafeImage: UIImageView!
    
    @IBOutlet weak var cafeNameLabel: UILabel!
  
    @IBOutlet weak var orderDateLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var orderInfo : OrderList?
    
    @IBOutlet weak var test: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (orderInfo?.caffeInfo == caffe1.caffeInfo){
            cafeImage.image = UIImage(named: caffe1.photo!)
            cafeNameLabel.text = caffe1.name
        }
        else if (orderInfo?.caffeInfo == caffe2.caffeInfo){
            cafeImage.image = UIImage(named: caffe2.photo!)
            cafeNameLabel.text = caffe2.name
        }
        else if (orderInfo?.caffeInfo == caffe3.caffeInfo){
            cafeImage.image = UIImage(named: caffe3.photo!)
            cafeNameLabel.text = caffe3.name
        }
        orderDateLabel.text = orderInfo?.orderDate
        totalPriceLabel.text = String(orderInfo!.totalPrice) + " 원"
        
        test.delegate = self
        test.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
