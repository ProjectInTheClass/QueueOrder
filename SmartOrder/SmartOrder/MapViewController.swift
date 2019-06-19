//
//  MapViewController.swift
//  SmartOrder
//
//  Created by 하영 on 20/06/2019.
//  Copyright © 2019 하영. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate{

    var mapView:MTMapView?
    var cafeInfo:Int = 0 //카페 고유번호
    
    @IBOutlet var daumMap: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MTMapView(frame: self.view.bounds)
        self.daumMap.addSubview(mapView!)

        // Do any additional setup after loading the view.
    }
    

    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        
        let locMap:(Double,Double) = cafeMapList[(cafeInfo)]
        
        let item = MTMapPOIItem()
        item.itemName = name
         item.markerType = .customImage                           //커스텀 타입으로 변경
        if latitude == locMap.0 && longitude == locMap.1 {
            //item.markerType = .redPin
            item.customImage = UIImage(named: "RedPoint")
        } else {
          
            item.customImage = UIImage(named: "BluePoint")
        }
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .noAnimation
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)    // 마커 위치 조정
        return item
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var items = [MTMapPOIItem]()
        items.append(poiItem(name: "큐카페", latitude: 37.555864, longitude: 127.049425))
        
        items.append(poiItem(name: "TIAMO 학술정보관점", latitude: 37.556587, longitude: 127.045954))
        
        items.append(poiItem(name: "TIAMO MK점", latitude: 37.555426, longitude: 127.045187))
       
        
        mapView!.addPOIItems(items)
        mapView!.fitAreaToShowAllPOIItems()  // 모든 마커가 보이게 카메라 위치/줌 조정
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
