//
//  StampViewController.swift
//  SmartOrder
//
//  Created by 하영 on 03/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentedStampCoupon: UISegmentedControl!
    @IBOutlet weak var stampOrCouponTable: UITableView!
    @IBOutlet weak var stamps: UICollectionView!
    
    var random : Int = 0
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
            cell.imageView?.image = UIImage(named: "beanIcon")
     
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
        print("View did load!")
        stampOrCouponTable.isHidden = true
        stamps.isHidden = false
        print("현재 스탬프 갯수")
        print(stampList.count)
        
        self.stamps.delegate = self
        self.stamps.dataSource = self
       
        stampOrCouponTable.rowHeight = 65
        
        random = Int.random(in: 0..<5)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.stamps.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
   
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if(isgauge){
            return caffeList.count
        }
        return caffe1.stampToCoupon
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(isgauge){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Gauge", for: indexPath) as! GaugeCollectionViewCell
            return cell.Base.bounds.size
        }
        else{
            let width = self.view.frame.size.width / 6.3
            return CGSize(width: width, height: width)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isgauge){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Gauge", for: indexPath) as!
            GaugeCollectionViewCell
            
            cell.CaffeImage.image = UIImage(named: caffeList[indexPath.item]!.logo!)
            cell.CaffeName.text = caffeList[indexPath.item]!.name
            cell.stamp = Int.random(in: 0 ..< 10)
            if(indexPath.item == random){
                cell.stamp += 10
            }
            cell.toStamp = caffeList[indexPath.item]!.stampToCoupon
            cell.HowMany.text = "\(cell.stamp) / \(cell.toStamp)"
            cell.Boundaries.layer.borderColor = UIColor.black.cgColor
            cell.Boundaries.layer.borderWidth = 1.0
            cell.Boundaries.layer.cornerRadius = cell.Boundaries.bounds.size.height / 2
            cell.Gauge.layer.cornerRadius = cell.Boundaries.bounds.size.height / 2
            
            print("\(String(describing: cell.CaffeName.text)) 의 스탬프 수: \(cell.stamp)")
          
            
            cell.couponCreate = UIAlertController(title: "\(caffeList[indexPath.item]!.name)의 쿠폰이 발급됩니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
            
            cell.couponCreate.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                cell.rate.constant = 0
                cell.Base.layoutIfNeeded()
                
                cell.stamp -= 10
                cell.HowMany.text = "\(cell.stamp) / \(cell.toStamp)"
                var rate : Double = 0
                
                
                let Today = NSDate()
                let nextMonth = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 30)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 M월 d일"
                
                let newCoupon =  Coupon(name:"2000원 할인쿠폰", caffe:"QUEUE", price:2000, issueDate:dateFormatter.string(from: Today as Date), expireDate:dateFormatter.string(from : nextMonth as Date), use:false)

                
                print(newCoupon)
                
                couponList.addCoupon(newCoupon)
               
                UIView.animate(withDuration: 1, animations: {
                    if(cell.stamp >= cell.toStamp){
                        rate = Double(cell.toStamp)
                    } else{
                        rate = Double(cell.stamp)
                    }
                    cell.rate.constant = (cell.CaffeImage.bounds.size.width) * CGFloat(rate) / CGFloat(cell.toStamp)
                    cell.Base.layoutIfNeeded()
                })
            }))
            
            var rate : Double = 0
            cell.Base.layoutIfNeeded()
            
            UIView.animate(withDuration: 1, animations: {
                cell.Base.setNeedsLayout()
                if(cell.stamp >= 10){
                    rate = Double(cell.toStamp)
                } else{
                    rate = Double(cell.stamp)
                }
                cell.rate.constant = (cell.CaffeImage.bounds.size.width) * CGFloat(rate) / CGFloat(cell.toStamp)
                cell.Base.layoutIfNeeded()
            }, completion: {
                yes in
                if(cell.stamp >= cell.toStamp){
                    if(self.presentedViewController == nil){
                        self.present(cell.couponCreate, animated: true)
                    }
                }
            })
            return cell
        }
        
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
