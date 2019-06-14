//
//  MyMenuViewController.swift
//  SmartOrder
//
//  Created by Ing on 07/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MyMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var NoMenuBtn: UIButton!
    @IBOutlet weak var NoMenu: UILabel!
    @IBOutlet weak var MyMenutable: UITableView!
    
    var CaffeName : [String] = []
    var FavoriteMenu : [[Menu]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CaffeName = []
        FavoriteMenu = []
        for i in 0 ..< MyMenu.count{
            if !MyMenu[i].isEmpty{
                CaffeName.append(caffeList[i]!.name)
                FavoriteMenu.append(MyMenu[i])
            }
        }
        
        if(CaffeName.isEmpty){
            self.MyMenutable!.isHidden = true
            self.NoMenuBtn.isHidden = false
            self.NoMenu.isHidden = false
        }
        else{
            self.MyMenutable!.isHidden = false
            self.NoMenuBtn.isHidden = true
            self.NoMenu.isHidden = true
        }
        self.MyMenutable.reloadData()
        self.loadViewIfNeeded()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteMenu[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return FavoriteMenu.count
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height = self.view.bounds.size.height
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: height / 35)
        myLabel.font = UIFont.boldSystemFont(ofSize: height / 40)
        myLabel.text = CaffeName[section]
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = self.view.bounds.size.height
        return height / 35
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMenu", for: indexPath) as! MyMenuTableViewCell
        
        cell.MenuName.text = FavoriteMenu[indexPath.section][indexPath.row].coffee
        
        cell.MenuPrice.text = "\(FavoriteMenu[indexPath.section][indexPath.row].price)원"
        
        if (indexPath.row % 2) == 0 {
            cell.MenuImage.image = UIImage(named: "coffee_picture_blue")
        } else{
            cell.MenuImage.image = UIImage(named: "coffee_picture_white")
        }
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "Order"){
        let destVC = segue.destination as! DetailViewController
        let selectedCoffee = FavoriteMenu[self.MyMenutable.indexPathForSelectedRow!.section][self.MyMenutable.indexPathForSelectedRow!.row]
        destVC.coffeeForView = selectedCoffee
        destVC.caffeInfo = self.MyMenutable.indexPathForSelectedRow!.section
        }
    }
}
