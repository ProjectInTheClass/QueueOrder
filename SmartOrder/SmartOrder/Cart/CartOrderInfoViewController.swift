//
//  CartOrderInfoViewController.swift
//  SmartOrder
//
//  Created by 하영 on 15/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class CartOrderInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var totalOrderPrice: UILabel!
    @IBOutlet weak var cartOrderBtn: UIButton!
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //데이터 삭제
        myCart.selectedMenu.remove(at: indexPath.row)
        cartSelectedArray.remove(at: indexPath.row)
        //셀 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = myCart.selectedMenu[indexPath.row]
        
        print("장바구니...\(selectedItem)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
    
        return 1
        //section 갯수
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
       
       return myCart.selectedMenu.count
       
        //cell 갯수
    }
   /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 111
        } else {
            return 111
        }
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCart", for: indexPath) as! CartOrderCell
            
            let CartForTheRow:Order = myCart.selectedMenu[indexPath.row]
            cell.price.text = "금액 \(CartForTheRow.price)원"
            cell.name.text = CartForTheRow.coffee
            
            if (indexPath.row % 2) == 0 {
                cell.img?.image = UIImage(named: "coffee_picture_blue")
            } else{
                cell.img?.image = UIImage(named: "coffee_picture_white")
            }
            
            cell.option.text = "사이즈\(CartForTheRow.size) / 얼음\(CartForTheRow.ice) / 샷추가\(CartForTheRow.shot)"
            
            cell.cnt.text = "수량 \(CartForTheRow.count)개"
        
        
            cell.cartNumber.text = String(indexPath.row)
            return cell
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        /*
         let destVC = segue.destination as! DetailViewController
         let selectedCoffee = coffeeSubscript[self.tableView.indexPathForSelectedRow.row] // 여기서 self : tableView Controller
         destVC.coffeeForview = selectedCoffee
         */
        let destVC = segue.destination as! CartDetailViewController
        let selectedCart = myCart.selectedMenu[self.cartTable.indexPathForSelectedRow!.row]
        destVC.CartForView = selectedCart
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTable.rowHeight = 111
        
        cartOrderBtn.backgroundColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0)
        cartOrderBtn.layer.cornerRadius = 5
        cartOrderBtn.layer.borderWidth = 1
        cartOrderBtn.layer.borderColor = UIColor(red: 98/255, green: 92/255, blue: 89/255, alpha: 1.0).cgColor
        
        for _ in 0..<myCart.selectedMenu.count {
            print("counting ... ")
        }
        var totalPrice:Int = 0
        for item in 0..<cartSelectedArray.count {
            if cartSelectedArray[item] == 1 {
                totalPrice += myCart.selectedMenu[item].price
            }
        }
        totalOrderPrice.text = "\(totalPrice) 원"
        
        
        print(cartSelectedArray)
        cartTable.reloadData()
       
       
        // Do any additional setup after loading the view.
    }
 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.viewDidLoad()
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