//
//  UserAssistant.swift
//  ControlCenter
//
//  Created by Erik on 11/30/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class UserAssistant: Object {
  @objc dynamic var id = 0
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var streak = 0
  @objc dynamic var weekStreak = 0
  @objc dynamic var maxStreak = 0
  @objc dynamic var cheatDays = 0
  @objc dynamic var dangerZone = false
  @objc dynamic var profilePicture = ""
  
  
  override static func primaryKey() -> String {
    return "id"
  }
  
  
  var fullName: String {
    return "\(firstName) \(lastName)"
  }
  
  
  class func fromJSON(_ json: JSON) -> UserAssistant {
    
    let userAssistant = UserAssistant()
    
    if let id = json["user_id"].int {
      userAssistant.id = id
    }
    
    if let streak = json["streak"].int {
      userAssistant.streak = streak
    }
    
    if let weekStreak = json["week_streak"].int {
      userAssistant.weekStreak = weekStreak
    }
    
    if let profilePicture = json["profile_pic"].string {
      userAssistant.profilePicture = profilePicture
    }
    
    if let maxStreak = json["maxStreak"].int {
      userAssistant.maxStreak = maxStreak
    }
    
    if let firstName = json["first_name"].string {
      userAssistant.firstName = firstName
    }
    
    if let lastName = json["last_name"].string {
      userAssistant.lastName = lastName
    }
    
    if let dangerZone = json["danger_zone"].bool {
      userAssistant.dangerZone = dangerZone
    }
    
    if let cheatDays = json["cheat_days"].int {
      userAssistant.cheatDays = cheatDays
    }
    
    return userAssistant
  }
  
}
