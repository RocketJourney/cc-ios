//
//  AppDelegate+Setup.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

import Crashlytics
import Fabric
import RealmSwift
import Reachability



extension AppDelegate {
    
  
  static let ratioImages: CGFloat = 0.286
  
  func initialSetup() -> Void {
    Fabric.with([Crashlytics.self])
    self.setupDB()
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.montserratBold(18), NSAttributedString.Key.foregroundColor : UIColor.white]
    
    
    UINavigationBar.appearance().tintColor = UIColor.rocketYellow()
    UINavigationBar.appearance().barTintColor = UIColor(hex: 0x333333)
    UINavigationBar.appearance().isTranslucent = false
    
    
    UITabBar.appearance().isOpaque = true
    UITabBar.appearance().backgroundColor = UIColor.white
    UITabBar.appearance().tintColor = UIColor.rocketYellow()
  }
  
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = deviceToken.hexEncodedString()
    NSLog("Device Token: \(token)")
    
    if self.isNetworkReachable(){
      User.current?.registerToke(token, completion: {
        NSLog("register ok ===> %@", token)
      }, error: { (error) in
        NSLog("error ====> %@", error.localizedDescription)
      })
    }
    
  }
  
  func setupDB() -> Void {
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
      if oldSchemaVersion < 1 {
        //add clubs to User
      }
      
      if oldSchemaVersion < 2 {
        //add id to User model
      }
      
      if oldSchemaVersion < 3 {
        // add permission to User model
      }
      
      if oldSchemaVersion < 4 {
        // add Spot model
      }
      
      if oldSchemaVersion < 5 {
        // add accesibleSpots to Club model
      }
      
      if oldSchemaVersion < 6 {
        // add spot model
      }
      
      if oldSchemaVersion < 7 {
        // add status attributes to Club
      }
      
      if oldSchemaVersion < 8 {
        // add assistans to Club and spot models
      }
      
      if oldSchemaVersion < 9 {
        //add paginator to club and spot models
      }
      
      if oldSchemaVersion < 10 {
        //add selectedSpot tu current User model
      }
      
      if oldSchemaVersion < 11 {
        //add selectedSpot tu current User model
      }
      
      if oldSchemaVersion < 12 {
        //add selectedSpot (dynamic) tu current User model
      }
      
      if oldSchemaVersion < 13 {
        //add paginate (dynamic) tu current Spot & club model
      }
    }
    
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 13, migrationBlock: migrationBlock)
    let _ = try! Realm(configuration: ControlCenterRealm.config)
  }
  
  
  func isNetworkReachable()->Bool{
    let reachability = Reachability()
    return reachability?.connection != Reachability.Connection.none
  }
}
