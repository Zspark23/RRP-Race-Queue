//
//  AppDelegate.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, .badge, .sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        DispatchQueue.main.async(execute: { ()
            let postBody = String(format: "{\"type\":\"iOS\",\"token\":\"%@\",\"userID\":\"\"}", token)
            let endBody = URL(string: "http://db.racereplay.co:8080/device/")
            var request = URLRequest(url: endBody!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30.0)
            
            request.httpMethod = "POST"
            request.httpBody = postBody.data(using: String.Encoding.utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //let session = URLSession()
            //let task = session.uploadTask(with: request, from: postBody.data(using: .utf8)!)
            //print(postBody)
            //print(postBody.data(using: .utf8)!)
        })
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"load"), object: nil)
        //let alert = userInfo["aps"]! as! [String : Any]
        //print(alert["alert"]!)
    }


}

