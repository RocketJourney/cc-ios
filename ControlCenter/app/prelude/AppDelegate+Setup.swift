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

extension AppDelegate {
  
  static let ratioImages: CGFloat = 0.286
  
  func initialSetup() -> Void {
    Fabric.with([Crashlytics.self])
    self.setupDB()
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.montserratBold(18), NSAttributedString.Key.foregroundColor : UIColor.white]
    
    
    UINavigationBar.appearance().tintColor = UIColor.rocketYellow()
    UINavigationBar.appearance().barTintColor = UIColor(hex: 0x333333)
    UINavigationBar.appearance().isTranslucent = false
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
    }
    
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 5, migrationBlock: migrationBlock)
    let _ = try! Realm(configuration: ControlCenterRealm.config)
  }
}
