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
      if response.response != nil{
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
                  realm.create(Spot.self, value: spotModel, update: .all)
                  clubModel.accesibleSpots.append(spotModel)
                }
                
                userModel.token = user.token
                userModel.clubs = user.clubs
                userModel.selectedSpot = user.selectedSpot
                realm.create(Club.self, value: clubModel, update: .all)
                userModel.currentClub = clubModel
                realm.create(User.self, value: userModel, update: .all)
              }
            }
          }
          completion()
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
      
    }
    
  }
  
  
  func getSpotStatus(clubId: Int, spotId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    
    Alamofire.request(UserRouter.getSpotStatus(clubId, spotId)).responseJSON { (response) in
      if response.response != nil{
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let spotModel = Spot.findByClubIdAndSpotId(clubId: clubId, spotId: spotId) {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                
                if let totalUsersCheckedIn = json["data"]["total_users_checked_in"].int {
                  spotModel.totalUsersCheckedIn = totalUsersCheckedIn
                  User.current?.selectedSpot?.totalUsersCheckedIn = totalUsersCheckedIn
                }
                
                if let totalUsersWithTeam = json["data"]["total_users_with_team"].int {
                  spotModel.totalUsersWithTeam = totalUsersWithTeam
                  User.current?.selectedSpot?.totalUsersWithTeam = totalUsersWithTeam
                }
                
                if let spotCount = json["data"]["spotCount"].int {
                  spotModel.spotCount = spotCount
                  User.current?.selectedSpot?.spotCount = spotCount
                }
                
                
              }
              
            }
            
          }
          completion()
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
    }
  }
  
  
  
  func getClubStatus(clubId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getClubStatus(clubId)).responseJSON { (response) in
      if response.response != nil {
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let club = User.current?.currentClub {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                
                if let totalUsersCheckedIn = json["data"]["total_users_checked_in"].int {
                  club.totalUsersCheckedIn = totalUsersCheckedIn
                  User.current?.currentClub?.totalUsersCheckedIn = totalUsersCheckedIn
                }
                
                if let totalUsersWithTeam = json["data"]["total_users_with_team"].int {
                  club.totalUsersWithTeam = totalUsersWithTeam
                  User.current?.currentClub?.totalUsersWithTeam = totalUsersWithTeam
                }
                
                if let spotCount = json["data"]["spotCount"].int {
                  club.spotCount = spotCount
                  User.current?.currentClub?.spotCount = spotCount
                }
                
              }
            }
          }
          completion()
        }else {
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
      
    }
  }
  
  
  func getClubAssistans(clubId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getClubAssistants(clubId)).responseJSON { (response) in
      if response.response != nil {
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let club = User.current?.currentClub {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                club.assistants = List<UserAssistant>()
                User.current?.currentClub?.assistants = List<UserAssistant>()
                User.current?.currentClub?.paginator = nil
                realm.create(User.self, value: User.current!, update: .all)
                let paginator = Paginator.fromJSON(json["data"])
                club.paginator = paginator
                let assistants = List<UserAssistant>()
                if let assistantsJson = json["data"]["users"].array {
                  for assistantJson in assistantsJson {
                    let assistant = UserAssistant.fromJSON(assistantJson)
                    realm.add(assistant, update: .all)
                    guard !(User.current?.currentClub?.assistants.contains(assistant))! else {
                      continue
                    }
                    club.assistants.append(assistant)
                    User.current?.currentClub?.assistants.append(assistant)
                  }
                }
                
                club.assistants = assistants
                realm.create(Club.self, value: club, update: .all)
                User.current?.currentClub = club
                User.current?.currentClub?.assistants = assistants
                realm.create(User.self, value: User.current!, update: .all)
              }
            }
            
          }
          completion()
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
      
    }    
  }
  
  
  func getSpotAssistans(clubId: Int, spotId: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getSpotAssistants(clubId, spotId)).responseJSON { (response) in
      
      if response.response != nil {
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let spot = User.current?.selectedSpot {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                User.current?.selectedSpot?.assistants = List<UserAssistant>()
                spot.assistants = List<UserAssistant>()
                let paginator = Paginator.fromJSON(json["data"])
                spot.paginator = paginator
                User.current?.selectedSpot?.paginator = paginator
                let assistants = List<UserAssistant>()
                
                if let assistantsJson = json["data"]["users"].array {
                  for assistantJson in assistantsJson {
                    let assistant = UserAssistant.fromJSON(assistantJson)
                    realm.add(assistant, update: .all)
                    assistants.append(assistant)
                    User.current?.selectedSpot?.assistants.append(assistant)
                  }
                }
                spot.assistants = assistants
                realm.create(Spot.self, value: spot, update: .all)
                let userModel = User.current
                userModel?.selectedSpot?.assistants = assistants
                realm.create(User.self, value: userModel!, update: .all)
              }
            }
          }
          completion()
        }else{
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
    }
  }
  
  func getClubAssistansPaginate(clubId: Int, page: Int ,completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getClubAssistantsPaginate(clubId, page)).responseJSON { (response) in
      if response.response != nil {
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let club = User.current?.currentClub {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                let paginator = Paginator.fromJSON(json["data"])
                club.paginator = paginator
                User.current?.currentClub?.paginator = paginator
                if let assistantsJson = json["data"]["users"].array {
                  for assistantJson in assistantsJson {
                    let assistant = UserAssistant.fromJSON(assistantJson)
                    realm.add(assistant, update: .all)
                    guard !(User.current?.currentClub?.assistants.contains(assistant))! else {
                      continue
                    }
                    User.current?.currentClub?.assistants.append(assistant)
                  }
                }
                
                
                realm.create(User.self, value: User.current!, update: .all)
              }
            }
          }
          completion()
        }else {
          error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
        }
      }else {
        error(NSError(domain: "request error", code: 501, userInfo: nil))
      }
      
    }
  }
  
  
  func getSpotAssistansPaginate(clubId: Int, spotId: Int, page: Int, completion: @escaping ()->(), error: @escaping(_ error: Error) -> ()) -> Void {
    Alamofire.request(UserRouter.getSpotAssistantsPaginate(clubId, spotId, page)).responseJSON { (response) in
      if response.response != nil {
        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! <= 204 {
          if let object = response.result.value {
            let json = JSON(object)
            if let spot = User.current?.selectedSpot {
              let realm = try! Realm(configuration: ControlCenterRealm.config)
              try! realm.write {
                
                let paginator = Paginator.fromJSON(json["data"])
                spot.paginator = paginator
                
                User.current?.selectedSpot?.paginator = paginator
                if let assistantsJson = json["data"]["users"].array {
                  for assistantJson in assistantsJson {
                    let assistant = UserAssistant.fromJSON(assistantJson)
                    realm.add(assistant, update: .all)
                    guard !(User.current?.selectedSpot?.assistants.contains(assistant))! else {
                      continue
                    }
                    User.current?.selectedSpot?.assistants.append(assistant)
                    
                  }
                }
                
                let userModel = User.current
                realm.create(User.self, value: userModel!, update: .all)
              }
            }
          }
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
