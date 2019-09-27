//
//  User+Login.swift
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
  class func signUp(_ email: String, name: String, lastName: String, password: String, invitationCode: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(LoginRouter.signUp(email, name, lastName, password, invitationCode)).responseJSON { (response) in
      print(String(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8)!)
      if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        if let object = response.result.value {
          let json = JSON(object)
          
          let user = User()
          user.email = email
          user.firstName = name
          user.lastName = lastName
          
          if let token = json["data"]["jwt"].string {
            user.token = token
          }
          
          if let id = json["data"]["user_id"].int {
            user.id = id
          }
          
          let club = Club.fromJSON(json["data"]["club"])
          user.currentClub = club
          
          let realm = try! Realm(configuration: ControlCenterRealm.config)
          try! realm.write {
            realm.deleteAll()
            realm.create(User.self, value: user, update: .all)
          }
        }
        
        
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
  }
  
  
  class func login(_ email: String, password: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(LoginRouter.login(email, password)).responseJSON { (response) in
      if(response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        if let object = response.result.value {
          let json = JSON(object)
          let user = User()
          user.email = email
          
          if let token = json["data"]["jwt"].string {
            user.token = token
          }
          
          if let id = json["data"]["user_id"].int {
            user.id = id
          }
          
          let realm = try! Realm(configuration: ControlCenterRealm.config)
          try! realm.write {
            realm.deleteAll()
            
            
            if let clubs = json["data"]["clubs"].array {
              for jsonClub in clubs{
                let clubModel = Club.fromJSON(jsonClub)
                realm.add(clubModel, update: .all)
                user.clubs.append(clubModel)
              }
            }
            realm.create(User.self, value: user, update: .all)
          }
        }
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
  }
  
  
  class func recoverPassword(_ email: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(LoginRouter.recoverPassword(email)).responseJSON { (response) in
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
  
  func registerToke(_ token: String, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(LoginRouter.registerToken(token)).responseJSON { (response) in      
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
}
