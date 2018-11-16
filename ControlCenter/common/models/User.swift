//
//  User.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
  @objc dynamic var email = ""
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var token = ""
  
  
  class var current:User? {
    do {
      let realm = try Realm(configuration: ControlCenterRealm.config)
      let users = realm.objects(User.self)
      let user = users.first
      return user
    } catch {
      return nil
    }
  }
}
