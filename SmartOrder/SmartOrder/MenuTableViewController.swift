//
//  MenuTableViewController.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    override func viewDidLoad() {
        
        super.viewDidLoad()

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
        return MenuSubscript.count
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
        
        let MenuForTheRow:Menu = MenuSubscript[indexPath.row]
        cell.textLabel?.text = MenuForTheRow.coffee
        cell.detailTextLabel?.text = String(MenuForTheRow.price)+"원"
        
        if (indexPath.row % 2) == 0 {
        cell.imageView?.image = UIImage(named: "그린커피_배경")
        } else{
            cell.imageView?.image = UIImage(named: "그린커피_배경_회색")
        }
        /*
        if indexPath.row > 4 {
            cell.textLabel?.text = "d"
            cell.detailTextLabel?.text = "Columbia"
            
        } else {
            cell.textLabel?.text = "Robusta"
            cell.detailTextLabel?.text = "vietnam"
        }
         */
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
        let destVC = segue.destination as! DetailViewController
        let selectedCoffee = MenuSubscript[self.tableView.indexPathForSelectedRow!.row]
        destVC.coffeeForView = selectedCoffee
    }
     
     //segue : 연결된 선 ? 통로 ? main.stroyboard 에서 control 누르고 연결햇을때 나타나는 선.
     
 

}
