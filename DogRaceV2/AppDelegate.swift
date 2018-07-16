//
//  AppDelegate.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/16/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let testRace = Race()
        
        let dog1 = Dog()
        let dog2 = Dog()
        let dog3 = Dog()
        let dog4 = Dog()
        let dog5 = Dog()
        let dog6 = Dog()

        
        dog1.number = 1
        dog1.odds = 7.8
        dog1.position = 3
        
        dog2.number = 2
        dog2.odds = 3.8
        dog2.position = 4
        
        dog3.number = 3
        dog3.odds = 12.0
        dog3.position = 5
        
        dog4.number = 4
        dog4.odds = 4.55
        dog4.position = 2
        
        dog5.number = 5
        dog5.odds = 7.8
        dog5.position = 1
        
        dog6.number = 6
        dog6.odds = 6.5
        dog6.position = 6
        
        testRace.id = 555
        testRace.dog1 = dog1
        testRace.dog2 = dog2
        testRace.dog3 = dog3
        testRace.dog4 = dog4
        testRace.dog5 = dog5
        testRace.dog6 = dog6
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(testRace)
            }
        } catch {
            print("Error during initialization real : \(error)")
        }
        
        
        return true
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

