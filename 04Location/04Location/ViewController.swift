//
//  ViewController.swift
//  04Location
//
//  Created by sven on 16/12/24.
//  Copyright © 2016年 sven. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate { // 代理不用写方括号了

    @IBOutlet weak var locationInfoLabel: UILabel!
    
//    var locationManager = CLLocationManager()
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func locationBtnClickAction(sender: AnyObject) {
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization() // 必须在infoPlist添加两个字段
//        （1）在 info.plist里加入定位描述（Value值为空也可以）：
//        NSLocationWhenInUseDescription ：允许在前台获取GPS的描述
//        NSLocationAlwaysUsageDescription ：允许在后台获取GPS的描述
        locationManager.startUpdatingLocation()
    }
    
    // 定位成功
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMark, error) in
//            if placeMark?.count > 0{
//                let pm = placeMark![0]
//                let city = pm.locality!
//                let country = pm.country!
////                let postCode = pm.postalCode // postalCode可能没有,直接这样写会崩溃
//                self.locationInfoLabel.text = city + country
//            }
//        }
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if placemarks?.count > 0{
                let pm = placemarks![0]
                let city = pm.locality! // 必须写个!
//                let country = pm.country!
                let subLocalCity = pm.subLocality != nil ? pm.subLocality : ""
                let postCode = pm.postalCode != nil ? pm.postalCode : ""
                let zone = pm.thoroughfare != nil ? pm.thoroughfare : ""
//                pm.formattedAddressLines
                self.locationInfoLabel.text = city + " " + subLocalCity! + " " + postCode! + zone!
            }else {
                self.locationInfoLabel.text = "CLGeocoder解析失败"
            }
        })
    }
}

// 关于!和?