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
    UINavigationBar.appearance().barTintColor = UIColor(hex: 0x1a1a1a)
    UINavigationBar.appearance().isTranslucent = false
  }
  
  func setupDB() -> Void {
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
      if oldSchemaVersion < 1 {
        //add clubs to User
      }
    }
    
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: migrationBlock)
    let _ = try! Realm(configuration: ControlCenterRealm.config)
  }
}
