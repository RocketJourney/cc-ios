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
    
    
    Alamofire.request(UserRouter.getSpotsFromClub(clubId)).responseJSON { (response) in
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
                realm.create(Spot.self, value: spotModel, update: true)
                clubModel.accesibleSpots.append(spotModel)
              }
              
              userModel.token = user.token
              userModel.clubs = user.clubs
              realm.create(Club.self, value: clubModel, update: true)
              userModel.currentClub = clubModel
              realm.create(User.self, value: userModel, update: true)
            }
          }
        }
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
    
  }
  
  
  func getSpotStatus(clubId: Int, spotId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    
    Alamofire.request(UserRouter.getSpotStatus(clubId, spotId)).responseJSON { (response) in
      if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        if let object = response.result.value {
          let json = JSON(object)
          if let spotModel = Spot.findByClubIdAndSpotId(clubId: clubId, spotId: spotId) {
            let realm = try! Realm(configuration: ControlCenterRealm.config)
            try! realm.write {
              
              if let totalUsersCheckedIn = json["data"]["total_users_checked_in"].int {
                spotModel.totalUsersCheckedIn = totalUsersCheckedIn
              }
              
              if let totalUsersWithTeam = json["data"]["total_users_with_team"].int {
                spotModel.totalUsersWithTeam = totalUsersWithTeam
              }
              
              if let spotCount = json["data"]["spotCount"].int {
                spotModel.spotCount = spotCount
              }
              
            }
          }
        }
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
  }
  
  
  
  func getClubStatus(clubId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getClubStatus(clubId)).responseJSON { (response) in
      if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        if let object = response.result.value {
          let json = JSON(object)
          if let club = User.current?.currentClub {
            let realm = try! Realm(configuration: ControlCenterRealm.config)
            try! realm.write {
              
              if let totalUsersCheckedIn = json["data"]["total_users_checked_in"].int {
                club.totalUsersCheckedIn = totalUsersCheckedIn
              }
              
              if let totalUsersWithTeam = json["data"]["total_users_with_team"].int {
                club.totalUsersWithTeam = totalUsersWithTeam
              }
              
              if let spotCount = json["data"]["spotCount"].int {
                club.spotCount = spotCount
              }
              
            }
          }
        }
      }else {
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
  }
  
  
  func getClubAssistans(clubId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getClubAssistants(clubId)).responseJSON { (response) in
      if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
        if let object = response.result.value {
          let json = JSON(object)
        }
        completion()
      }else {
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
  }
  
}
