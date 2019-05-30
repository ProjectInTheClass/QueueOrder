//
//  MenuTableViewController.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    //var menuForView:[Menu]? //추가-ㅎㅇ
    var cafeInfo:Int = 0 //카페 고유번호
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //navigation bar back 글씨 지우기
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
      
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        //section 갯수
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return MenuSubscript.count
        
        //수정-ㅎㅇ
        return ((caffeList[cafeInfo])?.menu.count)!
        //cell 갯수
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath)

        // Configure the cell...
        /*
        let coffeeForTheRow:Coffee = coffeeSubscript[indexPath.row]
        cell.textLabel?.text = coffeeForTheRow.name
        cell.detailTextLabel?.text = coffeeForTheRow.origin
         */
        //수정중-ㅎㅇ
        //let MenuForTheRow:Menu = MenuSubscript[indexPath.row]
        print(caffeList[cafeInfo])
        
        let MenuForTheRow:Menu = ((caffeList[cafeInfo])?.menu[indexPath.row])!
        cell.textLabel?.text = MenuForTheRow.coffee
        cell.detailTextLabel?.text = String(MenuForTheRow.price)+"원"
        
        if (indexPath.row % 2) == 0 {
        cell.imageView?.image = UIImage(named: "coffee_picture_blue")
        } else{
            cell.imageView?.image = UIImage(named: "coffee_picture_white")
        }
       
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
        
        if segue.identifier == "toBack" {
            let dVC = segue.destination as! CaffePreViewController
            dVC.item = "back"
        } else {
            
            let dVC = segue.destination as! DetailViewController
            let selectedCoffee = (caffeList[cafeInfo])?.menu[self.tableView.indexPathForSelectedRow!.row]
            dVC.coffeeForView = selectedCoffee
            dVC.caffeInfo = cafeInfo
            dVC.coffeeNum = self.tableView.indexPathForSelectedRow!.row
            print("선택한 메뉴 .. ")
            print(selectedCoffee)
            
        
        }
    }
     
     //segue : 연결된 선 ? 통로 ? main.stroyboard 에서 control 누르고 연결햇을때 나타나는 선.
     
 

}
