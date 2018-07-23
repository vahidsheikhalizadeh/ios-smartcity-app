//
//  AppDelegate.swift
//  smartCity
//
//  Created by shick on 16.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        FirebaseApp.configure()
        
        
        
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
      /*  let s1 = SensorDataModel()
        s1.name = "Temperatur"
        s1.id = 1
        
        saveSensorData(sensor: s1)
        
        let s2 = SensorDataModel()
        s2.name = "Luftfeuchtigkeit"
        s2.id = 2
        saveSensorData(sensor: s2)
        
        
        let s3 = SensorDataModel()
        s3.name = "Lichtsensor"
        s3.id = 3
        saveSensorData(sensor: s3)
        
        let s4 = SensorDataModel()
        s4.name = "Füllstand"
        s4.id = 4
        saveSensorData(sensor: s4)
        
        let s5 = SensorDataModel()
        s5.name = "Solar"
        s5.id = 5
        saveSensorData(sensor: s5)
        
        let s6 = SensorDataModel()
        s6.name = "Parkplatz"
        s6.id = 6
        saveSensorData(sensor: s6) */
 
 
        return true
    }
    
    func saveSensorData(sensor: SensorDataModel) {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(sensor)
            }
        } catch {
            print("Error saving category \(error)")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

