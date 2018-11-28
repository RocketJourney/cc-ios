//
//  Club.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Club: Object {
  
  @objc dynamic var id = 0
  @objc dynamic var nameSpace = ""
  @objc dynamic var name = ""
  @objc dynamic var logoUrl = ""
  var accesibleSpots = List<Spot>()
  
  
  
  override static func primaryKey() -> String {
    return "id"
  }
  
  
  class func fromJSON(_ json: JSON) -> Club {
    let club = Club()
    if let nameSpace = json["namespace"].string {
      club.nameSpace = nameSpace
    }
    
    if let name = json["name"].string {
      club.name = name
    }
    
    if let id = json["id"].int {
      club.id = id
    }
    
    if let logoUrl = json["logo"].string {
      club.logoUrl = logoUrl
    }
    return club
  }
}
