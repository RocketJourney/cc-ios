//
//  User.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class User: Object {
  
  @objc dynamic var id = 0
  @objc dynamic var email = ""
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var token = ""
  @objc dynamic var permission = ""
  @objc dynamic var currentClub: Club?
  
  var selectedSpot: Spot?
  var clubs = List<Club>()
    
  override static func primaryKey() -> String {
    return "id"
  }
  
  
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
  
  var sortedClubs:Results<Club> {
    get{
      let sortDescriptors = [SortDescriptor(keyPath: "name", ascending: true)]
      return self.clubs.sorted(by: sortDescriptors)
    }
  }
    
  var fullName: String {
    return "\(firstName) \(lastName)"
  }
  
  
  class func fromJSON(_ json: JSON) -> User {
    let user = User()
    
    if let id = json["id"].int {
      user.id = id
    }
        
    if let firstName = json["first_name"].string {
      user.firstName = firstName
    }
    
    if let lastName = json["last_name"].string {
      user.lastName = lastName
    }
    
    if let permission = json["permission"].string {
      user.permission = permission
    }
    
    if let token = json["jwt"].string {
      user.token = token
    }
    
    return user
  }
}
