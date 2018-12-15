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
  class func validateInvitation(_ invitationCode: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(InvitationRouter.validateInvitation(invitationCode)).responseJSON { (response) in
      if response.response != nil {
        if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          completion()
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
      
    }
  }
  
  
  
  class func validateInvitationWhitEmail(_ invitationCode: String, email: String,completion: @escaping (_ statusCode: Int)->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(InvitationRouter.validateInvitationWithEmail(invitationCode, email)).responseJSON { (response) in
      if response.response != nil {
        if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          completion((response.response?.statusCode)!)
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
    }
  }
  
  func createInvitation(_ params: [String : Any], completion: @escaping (_ link: String)->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire .request(InvitationRouter.createInvitation(params)).responseJSON { (response) in
      
      if response.response != nil {
        if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let link = json["data"]["invitation_link"].string {
              completion(link)
            }
          }
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }      
    }
  }
}

