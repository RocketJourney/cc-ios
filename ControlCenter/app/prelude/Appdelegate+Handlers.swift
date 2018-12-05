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
    #if DEBUG
    Branch.setUseTestBranchKey(true)
    #elseif RELEASE
    Branch.setUseTestBranchKey(false)
    #endif
    
    let branch = Branch.getInstance()
    
    branch?.initSession(launchOptions: launchOptions, isReferrable: true,
                        andRegisterDeepLinkHandler: { params, error in
                          if let params = params {
                            NSLog("params %@", params)
                            let json = JSON(params)
                            //NSLog("json %@", json)
                            
                            if let invitationCode = json["invitation_code"].string {
                              NSLog(invitationCode)
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                                NotificationCenter.default.post(name: Notification.Name("showPreludeViewController"), object: nil)
                              })
                              
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                                let userInfo = ["invitationCode" : invitationCode]
                                NotificationCenter.default.post(name: Notification.Name("invitationCodeNotification"), object: nil, userInfo: userInfo)
                              })
                              
                              
                            }
                          } else {
                            NSLog("HOLAA")
                          }
    })
  }
  
  
  func handleDeepLinkWithBranch(_ url:URL)->Bool {
    return Branch.getInstance().handleDeepLink(url)
  }
}
