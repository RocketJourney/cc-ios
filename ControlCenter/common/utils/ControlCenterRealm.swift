//
//  ControlCenterRealm.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift

class ControlCenterRealm {
  static var inMemory = false
  static var name = "0cmxdb.realm"
  static func _config()->Realm.Configuration {
    if inMemory {
      return Realm.Configuration(fileURL: nil, inMemoryIdentifier: "testConfig\(name)", encryptionKey: nil, readOnly: false, schemaVersion: 2, migrationBlock: { version, oldVersion in
        
      }, objectTypes: nil)
    } else {
      return Realm.Configuration.defaultConfiguration
    }
  }
  fileprivate static var configuration:Realm.Configuration?
  static var config:Realm.Configuration {
    if let configuration = configuration {
      return configuration
    } else {
      configuration = _config()
      return configuration!
    }
  }
  
}
