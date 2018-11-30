//
//  Spot.swift
//  ControlCenter
//
//  Created by Erik on 11/28/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Spot: Object {
  @objc dynamic var id = 0
  @objc dynamic var clubId = 0
  @objc dynamic var branchName = ""
  @objc dynamic var name = ""
  @objc dynamic var badgeUrl = ""
  @objc dynamic var totalUsersWithTeam = 0
  @objc dynamic var totalUsersCheckedIn = 0
  @objc dynamic var spotCount = 0
  
  
  override static func primaryKey() -> String {
    return "id"
  }
  
  
  class func findByClubIdAndSpotId(clubId: Int, spotId: Int) -> Spot? {
    do {
      let realm = try Realm(configuration: ControlCenterRealm.config)      
      let arrayResult = realm.objects(Spot.self).filter("id = %@ AND clubId = %@", spotId, clubId)
      if arrayResult.count > 0{
        return arrayResult.first!
      }else{
        return nil
      }
      
    } catch {
      return nil
    }
  }
  
  
  class func fromJSON(_ json: JSON) -> Spot {
    let spot = Spot()
    if let branchName = json["branch_name"].string {
      spot.branchName = branchName
    }
    
    if let name = json["name"].string {
      spot.name = name
    }
    
    if let id = json["id"].int {
      spot.id = id
    }
    
    if let badgeUrl = json["logo"].string {
      spot.badgeUrl = badgeUrl
    }
    
    if let clubId = json["club_id"].int {
      spot.clubId = clubId
    }
    
    if let totalUserWithTeam = json["total_users_with_team"].int {
      spot.totalUsersWithTeam = totalUserWithTeam
    }
    
    if let totalUsersCheckedIn = json["total_users_checked_in"].int {
      spot.totalUsersCheckedIn = totalUsersCheckedIn
    }
    
    if let spotCount = json["spot_count"].int {
      spot.spotCount = spotCount
    }
    
    return spot
  }
}
