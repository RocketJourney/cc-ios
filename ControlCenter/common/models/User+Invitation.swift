//
//  User+Invitation.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Alamofire

extension User {
  func validateInvitation(_ invitationCode: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    
    Alamofire.request(InvitationRouter.validateInvitation(invitationCode)).responseJSON { (response) in
      if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        completion()
      }else{
        error(NSError(domain: "request error", code: 100, userInfo: nil))
      }
    }
  }
}

