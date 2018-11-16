//
//  Appdelegate+Handlers.swift
//  ControlCenter
//
//  Created by Erik on 11/14/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import Branch
import SwiftyJSON

extension AppDelegate {
  
  func setupBranch(_ launchOptions:[AnyHashable: Any]?) {
    Branch.setUseTestBranchKey(true)
    let branch = Branch.getInstance()
    
    branch?.initSession(launchOptions: launchOptions, isReferrable: true,
                        andRegisterDeepLinkHandler: { params, error in
                          if let params = params {
                            print(params)
                            let json = JSON(params)
                            print(json)
                            if let invitationCode = json["invitation_code"].string {
                              print(invitationCode)
                              NotificationCenter.default.post(name: Notification.Name("InvitationCodeNotification"), object: ["invitationCode" : invitationCode])
                              
                            }
                          } else {
                            print("HOLAA")
                          }
    })
  }
  
  
  func handleDeepLinkWithBranch(_ url:URL)->Bool {
    return Branch.getInstance().handleDeepLink(url)
  }
}
