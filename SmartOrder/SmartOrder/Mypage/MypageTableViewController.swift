//
//  MypageTableViewController.swift
//  SmartOrder
//
//  Created by Jeong on 15/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MypageTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "주문내역"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentUserInfo.orderList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //데이터 삭제
        currentUserInfo.orderList.remove(at: indexPath.row)
        //셀 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MypageTableViewCell
        let order =  currentUserInfo.orderList[indexPath.row]
        // Configure the cell...
        if (order.caffeInfo == caffe1.caffeInfo){
            cell.cafeImage.image = UIImage(named: caffe1.photo!)
            cell.cafeName.text = caffe1.name
        }
        else if (order.caffeInfo == caffe2.caffeInfo){
            cell.cafeImage.image = UIImage(named: caffe2.photo!)
            cell.cafeName.text = caffe2.name
        }
        else if (order.caffeInfo == caffe3.caffeInfo){
            cell.cafeImage.image = UIImage(named: caffe3.photo!)
            cell.cafeName.text = caffe3.name
        }
        cell.dayInfo.text = order.orderDate
        cell.totalPrice.text = String(order.totalPrice)+" 원"
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        if (segue.identifier == "DetailViewSegue"){
            // segue가 가리키는 목적지 찾기(없을수도 있다.) 있으면 DetailViewController타입으로 destination 저장.
            if let destination = segue.destination as? MypageDetailViewController{
                // 선택한 인덱스 받아오기. self.tableView.indexPathForSelectedRow?.row
                if let selectedIndex = self.tableView.indexPathForSelectedRow?.row{
                    // 인덱스를 가지고! 배열에서 선택한 퀑의 정보까지 받아오기.
                    let selectedOrder = currentUserInfo.orderList[selectedIndex] as OrderList
                    // 목적지의 변수에다가 선택 정보 넘겨주기/
                    destination.orderInfo = selectedOrder
                }
            }
        }
    }
 

}
