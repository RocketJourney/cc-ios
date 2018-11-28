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
  
  
  override static func primaryKey() -> String {
    return "id"
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
    
    return spot
  }
}
