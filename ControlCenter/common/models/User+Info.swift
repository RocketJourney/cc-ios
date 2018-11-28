//
//  User+Info.swift
//  ControlCenter
//
//  Created by Erik on 11/28/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift

extension User {
  
  func getSpotsFromClub(_ clubId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    
    
    Alamofire.request(UserRouter.getSpotsFromClub(clubId: clubId)).responseJSON { (response) in
      if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        
        if let object = response.result.value {
          let json = JSON(object)
          
          
          let realm = try! Realm(configuration: ControlCenterRealm.config)
          try! realm.write {
            if let user = User.current {
              let userJson = json["data"]["user"]
              let clubJson = json["data"]["club"]
              let spotsJsonArray = json["data"]["accesible_spots"].array
              let userModel = User.fromJSON(userJson)
              let clubModel = Club.fromJSON(clubJson)
              
              for spotJson in spotsJsonArray! {
                let spotModel = Spot.fromJSON(spotJson)
                realm.add(spotModel, update: true)
                clubModel.accesibleSpots.append(spotModel)
              }
              
              userModel.token = user.token
              user.currentClub = clubModel
              
              realm.add(clubModel, update: true)
              realm.add(userModel, update: true)
            }
          }
        }
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
    
  }
  
}
