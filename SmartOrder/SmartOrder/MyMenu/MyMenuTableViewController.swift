//
//  MyMenuTableViewController.swift
//  SmartOrder
//
//  Created by Ing on 14/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var CaffeName : [String] = []
    var FavoriteMenu : [[Menu]] = []
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //사용자가 선호메뉴로 등록한 메뉴만을 저장한 caffemenu와 해당 menu를 판매하는 caffe의 이름 저장
        for i in 0 ..< MyMenu.count{
            if !MyMenu[i].isEmpty{
                CaffeName.append(caffeList[i]!.name)
                FavoriteMenu.append(MyMenu[i])
            }
        }
    }

    // MARK: - Table view data source
    // 사용자가 좋아하는 메뉴를 판매하는 카페의 수만큼 section 생성
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return FavoriteMenu.count
    }
    //각 카페별 사용자가 선호메뉴로 지정한 메뉴의 수 만큼 row 생성
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavoriteMenu[section].count
    }
    //각 카페별 header를 설정해 어떤 카페의 메뉴인지 알 수 있도록 함.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //add header for each section
       
        return CaffeName[section]
    }
    
    //cell의 data 설정
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
    
    //사용자가 한 cell 선택시 해당 cell의 메뉴의 option선택창으로 이동
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destVC = segue.destination as! DetailViewController
        let selectedCoffee = FavoriteMenu[self.tableView.indexPathForSelectedRow!.section][self.tableView.indexPathForSelectedRow!.row]
        destVC.coffeeForView = selectedCoffee
        destVC.caffeInfo = self.tableView.indexPathForSelectedRow!.section
    }
    

}
