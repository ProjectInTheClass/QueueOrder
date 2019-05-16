//
//  MyMenuTableViewController.swift
//  SmartOrder
//
//  Created by Ing on 14/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var FavoriteIndex : [Int] = []
    var FavoriteMenu : [[Menu]] = MyMenu.filter({ !$0.isEmpty })
    

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
        return FavoriteMenu.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavoriteMenu[section].count
    }
/*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //add header for each section
    }
*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMenu", for: indexPath)
        
        cell.textLabel?.text = FavoriteMenu[indexPath.section][indexPath.row].coffee
        cell.detailTextLabel?.text = "\(FavoriteMenu[indexPath.section][indexPath.row].price)원"
        
        if (indexPath.row % 2) == 0 {
            cell.imageView?.image = UIImage(named: "coffee_picture_blue")
        } else{
            cell.imageView?.image = UIImage(named: "coffee_picture_white")
        }
        // Configure the cell...

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
        
        let destVC = segue.destination as! DetailViewController
        let selectedCoffee = FavoriteMenu[self.tableView.indexPathForSelectedRow!.section][self.tableView.indexPathForSelectedRow!.row]
        destVC.coffeeForView = selectedCoffee
        destVC.caffeInfo = self.tableView.indexPathForSelectedRow!.section
    }
    

}
