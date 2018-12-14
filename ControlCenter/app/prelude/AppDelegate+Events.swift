//
//  AppDelegate+Events.swift
//  ControlCenter
//
//  Created by Erik on 12/13/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import SwiftyJSON

public let kNewCheckInSpotCC = "NEW_CHECKIN_ON_SPOT_FOR_CC"

extension AppDelegate {
  func receivedPayload(_ userInfo:[AnyHashable: Any], state: UIApplication.State) {
    let json = JSON(userInfo)
    let payload = json["payload"]
    NSLog("payload  ===> %@", payload.description)
    Notifications.instance.pushPayload(payload, state: state)
    
  }
  
}
