//
//  StampViewController.swift
//  SmartOrder
//
//  Created by 하영 on 03/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var segmentedStampCoupon: UISegmentedControl!
    @IBOutlet weak var stampOrCouponTable: UITableView!
    @IBOutlet weak var stamps: UICollectionView!
    
    //table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedStampCoupon.selectedSegmentIndex == 1 {
            return stampList.count
        }
        else if segmentedStampCoupon.selectedSegmentIndex == 2 {
            return couponList.coupons.count
        }
        else {
            return 0
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
        case 1:
            let selectedItem = stampList[indexPath.row]
            print(selectedItem)
        case 2:
            let selectedItem = couponList.coupons[indexPath.row]
            print(selectedItem)
        default:
            break
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var resCell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
        if segmentedStampCoupon.selectedSegmentIndex == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
            
            var name:String! = "없음"
            if let caffe:String = caffeList[stampList[indexPath.row].caffeInfo]?.name {
                name = caffe
            }
            
            cell.textLabel?.text = "\(name!) \(stampList[indexPath.row].info)"
            cell.detailTextLabel?.text = stampList[indexPath.row].issueDate
            cell.imageView?.image = UIImage(named: "bean_mini")
     
            resCell = cell
        }
        else if segmentedStampCoupon.selectedSegmentIndex == 2 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
            
            var name:String! = "없음"
            if let caffe:String = couponList.coupons[indexPath.row].caffe {
                name = caffe
            }
            
            let coupon = couponList.coupons[indexPath.row].name
            
            cell.textLabel?.text = "\(name!) \(coupon)"
            cell.detailTextLabel?.text = "유효기간 : \(couponList.coupons[indexPath.row].issueDate)~\(couponList.coupons[indexPath.row].expireDate)"
            
            if coupon.hasPrefix("2000"){
                cell.imageView?.image = UIImage(named: "2000coupon")
            } else {
                cell.imageView?.image = UIImage(named: "freeCoupon")
            }
            
            resCell = cell
        }
        return resCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stampOrCouponTable.isHidden = true
        stamps.isHidden = false
        print("현재 스탬프 갯수")
        print(stampList.count)
        
        self.stamps.delegate = self
        self.stamps.dataSource = self
       
        stampOrCouponTable.rowHeight = 65
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
   
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return caffe1.stampToCoupon
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Stamp", for: indexPath) as! StampsCollectionViewCell
        // Configure the cell
        
        if indexPath.item < stampList.count {
            print(cell.img)
            cell.img?.image = UIImage(named: "queuestamp1")
            
        } else {
            cell.img?.image = UIImage(named: "queuestamp0")
        }
        
        return cell
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
        case 1:
            stampOrCouponTable.isHidden = false
            stamps.isHidden = true
            stampOrCouponTable.reloadData()
            break
            
        case 2:
            stampOrCouponTable.isHidden = false
            stamps.isHidden = true
            stampOrCouponTable.reloadData()
            break
        default:
            stampOrCouponTable.isHidden = true
            stamps.isHidden = false
            stamps.reloadData()
            break
            
        }
    }
}
