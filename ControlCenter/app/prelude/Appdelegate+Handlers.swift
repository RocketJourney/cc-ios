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
//                            if let type = json["type"].string {
//                              if type == "invite" {
//                                if let uuid = json["uuid"].string {
//                                  self.requestInviteData(uuid)
//                                }
//                              }
//                            }
                          } else {
                            print("HOLAA")
                          }
    })
  }
  
  
  func handleDeepLinkWithBranch(_ url:URL)->Bool {
    return Branch.getInstance().handleDeepLink(url)
  }
}
