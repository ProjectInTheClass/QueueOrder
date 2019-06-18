//
//  ConfirmViewController.swift
//  SmartOrder
//
//  Created by Ing on 16/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit
import UserNotifications

class ConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "주문이 완료되었습니다."
        content.subtitle = "큐카페 - 카페라떼"
        content.body = "음료를 찾아가 주세요!"
        content.summaryArgument = "주문완료"
        content.summaryArgumentCount = 40
        
        //2. Use TimeIntervalNotificationTrigger
        let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        //Adding Request
        // MARK: - identifier가 다 달라야만 Notification Grouping이 됩니닷..!!
        let request = UNNotificationRequest(identifier: "\(index)timerdone", content: content, trigger: TimeIntervalTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    //쿠폰의 경우 쿠폰 리스트가 카페별로 저장된게 아니라서
    //일단 테스트를 진행하기 위해서 datacenter의 couponlist를
    //사용했습니다. 추후 쿠폰리스트의 변경시 추가 수정 하겠습니다.
    //그리고 쿠폰은 한번에 한장씩만 사용하도록 했습니다.
    //Queue cafe는 여러개 사용 가능한데 이부분은... 나중에 생각해보겠습니다.
    
    //변수
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeImage: UIImageView!
    @IBOutlet weak var cafeLocation: UILabel!
    
    let colorForSelected: UIColor = UIColor(red:153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    let colorForNotSelected : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    var items : cart!
    
    var couponlist : [Coupon] = []
    var couponindex : [Int] = []
    
    var CouponSelected : (Int , Coupon)?
    var total : Int = 0
 
    var confirmController : [UIAlertController] = []
    var cancelController : [UIAlertController] = []
    
    //init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 여기 options에 원하는 option넣기.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { (didAllow, error) in
            
        })
        UNUserNotificationCenter.current().delegate = self
        //이부분의 경우 카페 내부 이미지를 보여주고 싶은데
        //사진이 없는경우 넣어줄 default사진을 정하면 추후 수정하겠습니다.
        //지금은 Logo로 넣어두겠습니다.
        if caffeList[items.selectedMenu[0].caffeInfo]!.photo != nil {
            cafeImage.image = UIImage(named:(caffeList[items.selectedMenu[0].caffeInfo]!.photo)!)
        } else {
            if caffeList[items.selectedMenu[0].caffeInfo]!.logo != nil {
                cafeImage.image = UIImage(named:(caffeList[items.selectedMenu[0].caffeInfo]!.logo)!)
            } else {
                cafeImage.image = UIImage(named:"dummy")!
            }
        }
        cafeName.text = caffeList[items.selectedMenu[0].caffeInfo]!.name
        cafeLocation.text = caffeList[items.selectedMenu[0].caffeInfo]!.location
        cafeLocation.numberOfLines = 0
        
        for i in 0 ..< couponList.coupons.count{
            if !couponList.coupons[i].use{
                couponlist.append(couponList.coupons[i])
                couponindex.append(i)
            }
        }
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dismissFunc), name: UIApplication.willResignActiveNotification, object: nil)
        // Do any additional setup after loading the view.
        
    }
    //total값 계산
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        total = 0
        for order in items.selectedMenu{
            total += order.price
        }
        if let selected = CouponSelected{
            print("It saved")
            total -= selected.1.price
        }
        if self.total < 0{
            self.Total.text = "0원"
        } else{
            self.Total.text = "\(self.total)원"
        }
    }
    //cell갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponlist.count
    }
    
    //cell 선택시 경고창 출력과 쿠폰 사용 결과 최종 가격만 변경
    //CouponSelected에 coupon index와 coupon값 저장
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row < couponlist.count){
            return;
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath)
       
        if let selected = CouponSelected{
            print("\(selected.0)와 \(indexPath.row)는 같은가요?")
            if selected.0 == self.couponindex[indexPath.row]{
                self.present(cancelController[indexPath.row], animated: true)
                }
            else{
                self.present(confirmController[indexPath.row], animated: true)
            }
        }
        else{
            self.present(confirmController[indexPath.row], animated: true)
        }
        
    }
    
    //header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "사용가능 쿠폰"
    }
    
    //선택 사항에 따른 색 변경( 적용 여부는 잘 모르겠네요...)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let selected = CouponSelected{
            if selected.0 == indexPath.row{
                cell.backgroundColor = colorForSelected
            }
            else{
                cell.backgroundColor = colorForNotSelected
            }
        }
        else{
            cell.backgroundColor = colorForNotSelected
        }
     
    }
    
    //각 cell별 데이터 설정 및 alert창 선언, action정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coupon", for: indexPath)
       
        cell.textLabel?.text = couponlist[indexPath.row].name
        cell.detailTextLabel?.text = "\(couponlist[indexPath.row].price)원"
        
        //쿠폰 선택 alert
        if(confirmController.count < indexPath.row){
            confirmController.append(UIAlertController(title: "\(couponlist[indexPath.row].name)을 사용하시겠습니까?", message: "이미 적용중인 쿠폰이 있다면 적용중인 쿠폰은 취소됩니다.", preferredStyle: .alert))
        //쿠폰 취소 alert
            cancelController.append(UIAlertController(title: "\(couponlist[indexPath.row].name)의 사용을 취소하시겠습니까?", message: "", preferredStyle : .alert))
        
        //쿠폰 선택시 action(쿠폰 중복 사용 불가)
            confirmController[indexPath.row].addAction(UIAlertAction(title: "확인", style: .default){
                UIAlertAction in
            
                if let selected = self.CouponSelected{
                    print("\(selected.1.name) 대신 \(self.couponlist[indexPath.row].name)이 사용됩니다.")
                    self.total += selected.1.price
                    self.CouponSelected = (self.couponindex[indexPath.row], self.couponlist[indexPath.row])
                    self.total -= self.couponlist[indexPath.row].price
                    if self.total < 0{
                        self.Total.text = "0원"
                    } else{
                        self.Total.text = "\(self.total)원"
                    }
                } else {
                    print("\(couponList.coupons[indexPath.row].name)이 사용됩니다.")
                    self.CouponSelected = (self.couponindex[indexPath.row], self.couponlist[indexPath.row])
                    self.total -= self.couponlist[indexPath.row].price
                    if self.total < 0{
                        self.Total.text = "0원"
                    } else{
                        self.Total.text = "\(self.total)원"
                    }
                }
            })
        //취소 선택지
            confirmController[indexPath.row].addAction(UIAlertAction(title: "취소", style: .cancel))
        
        
        //쿠폰 선택 취소 확인시 action
            cancelController[indexPath.row].addAction(UIAlertAction(title: "확인", style: .default){
                UIAlertAction in
            
                if let selected = self.CouponSelected{
                    print("\(selected.1.name)의 사용이 취소됩니다.")
                    self.CouponSelected = nil
                    self.total += selected.1.price
                    self.Total.text = "\(self.total)원"
                }
            
            })
            //쿠폰 선택 취소 취소 선택지
            cancelController[indexPath.row].addAction(UIAlertAction(title: "취소", style: .cancel))
        }
        //image setting인데 이건 coupon마다 image생성시 바꾸겠습니다.
        if couponlist[indexPath.row].name.hasPrefix("2000"){
            cell.imageView?.image = UIImage(named: "2000coupon")
        }else{
            cell.imageView?.image = UIImage(named: "freeCoupon")
        }
        
        return cell
        
    }

    
    // controller를 cell마다 사용해서 어떤 alert창이 뜨는 중인지 몰라서
    // 그냥 home버튼 누르면 다 지우도록 했는데 되긴 하네요 ㅎㅎ...
    @objc func dismissFunc(){
        for i in 0 ..< confirmController.count{
            self.confirmController[i].dismiss(animated: true)
            self.cancelController[i].dismiss(animated: true)
        }
    }
    //선택된 쿠폰과 함께 결제할 물품들을 결제controller로 넘겨줌
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! PayViewController
        destVC.items = self.items
        if let selected = CouponSelected{
            destVC.couponindex = selected.0
        }
    }
    
    
}

extension ConfirmViewController : UNUserNotificationCenterDelegate{
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
    }
    
}
