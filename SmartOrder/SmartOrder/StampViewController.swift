//
//  StampViewController.swift
//  SmartOrder
//
//  Created by 하영 on 03/05/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stampList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = stampList[indexPath.row]
        print(selectedItem)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyStamp", for: indexPath)
        
        var name:String! = "없음" 
        if let caffe:String = caffeList[stampList[indexPath.row].caffeInfo] {
            name = caffe
        }
        
        cell.textLabel?.text = "\(name!) \(stampList[indexPath.row].info)"
        cell.detailTextLabel?.text = stampList[indexPath.row].issueDate
        cell.imageView?.image = UIImage(named: "원두")
 
        /*
         let cell2 = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
         cell2.textLabel?.text = memberList[indexPath.row].phone
         */
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
