//
//  StampViewController.swift
//  SmartOrder
//
//  Created by 하영 on 03/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var segmentedStampCoupon: UISegmentedControl!
    @IBOutlet weak var stampOrCouponTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedStampCoupon.selectedSegmentIndex == 0 {
            return stampList.count
        }
        else {
            return couponList.coupons.count
        }
        /*
        switch segmentedStampCoupon.selectedSegmentIndex
        {
        case 0:
            return stampList.count
        case 1:
            return couponList.coupons.count
        default:
            return 0
        }*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedStampCoupon.selectedSegmentIndex
        {
        case 0:
            let selectedItem = stampList[indexPath.row]
            print(selectedItem)
        case 1:
            let selectedItem = couponList.coupons[indexPath.row]
            print(selectedItem)
        default:
            break
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var resCell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
        if segmentedStampCoupon.selectedSegmentIndex == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
            
            var name:String! = "없음"
            if let caffe:String = caffeList[stampList[indexPath.row].caffeInfo] {
                name = caffe
            }
            
            cell.textLabel?.text = "\(name!) \(stampList[indexPath.row].info)"
            cell.detailTextLabel?.text = stampList[indexPath.row].issueDate
            cell.imageView?.image = UIImage(named: "원두")
     
            resCell = cell
        }
        else if segmentedStampCoupon.selectedSegmentIndex == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
            
            var name:String! = "없음"
            if let caffe:String = couponList.coupons[indexPath.row].caffe {
                name = caffe
            }
            
            var coupon = couponList.coupons[indexPath.row].name
            
            cell.textLabel?.text = "\(name!) \(coupon)"
            cell.detailTextLabel?.text = "유효기간 : \(couponList.coupons[indexPath.row].issueDate)~\(couponList.coupons[indexPath.row].expireDate)"
            
            
            if coupon.hasPrefix("2000"){
                cell.imageView?.image = UIImage(named: "2000원 할인쿠폰")
            } else {
                cell.imageView?.image = UIImage(named: "음료쿠폰")
            }
            resCell = cell
        }
        return resCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func valueChanged(_ sender: Any) {
        switch segmentedStampCoupon.selectedSegmentIndex {
        case 0:
            stampOrCouponTable.reloadData()
            break
            
        case 1:
            stampOrCouponTable.reloadData()
            break
        default:
            break
            
        }
    }
}
