//
//  Notifications.swift
//  ControlCenter
//
//  Created by Erik on 12/13/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc protocol NotificationsListener {
  @objc optional func showUsers()
}



class Notifications {
  var listeners:[NotificationsListener] = [NotificationsListener]()
  
  class var instance: Notifications {    
    struct Static {
      static let instance: Notifications = Notifications()
    }
    return Static.instance
  }
  
  func pushPayload(_ json:JSON, state: UIApplication.State) {    
    if let type = json["type"].string {
      switch type {
      case kNewCheckInSpotCC:
        _ = self.listeners.map({$0.showUsers?()})
      default:
        NSLog("Nothing to do")
      }
    }
  }
}
