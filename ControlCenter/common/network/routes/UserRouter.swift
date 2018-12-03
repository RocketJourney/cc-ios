//
//  UserRouter.swift
//  ControlCenter
//
//  Created by Erik on 11/28/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
  
  case getSpotsFromClub(Int)
  case getSpotStatus(Int, Int)
  case getClubStatus(Int)
  case getClubAssistants(Int)
  case getSpotAssistants(Int, Int)
  
  func asURLRequest() throws -> URLRequest {
    
    let urlRequest = RequestBuilderV2.build(path, method: method)
    switch self {
      
    case .getSpotsFromClub(_):
      break
    case .getSpotStatus(_, _):
      break
    case .getClubStatus(_):
      break
    case .getClubAssistants(_):
      break
    case .getSpotAssistants(_, _):
      break
    }
    
    return urlRequest
  }
  
  
  var path: String {
    switch self {
    case .getSpotsFromClub(let clubId):
      return "/clubs/\(clubId)/spots"
    case .getSpotStatus(let clubId, let spotId):
      return "/clubs/\(clubId)/spots/\(spotId)/status"
    case .getClubStatus(let clubId):
      return "/clubs/\(clubId)/spots/all_spots/status"
    case .getClubAssistants(let clubId):
      return "/clubs/\(clubId)/spots/all_spots/users"
    case .getSpotAssistants(let clubId, let spotId):
      return "/clubs/\(clubId)/spots/\(spotId)/users"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSpotsFromClub(_),
         .getSpotStatus(_, _),
         .getClubStatus(_),
         .getClubAssistants(_),
         .getSpotAssistants(_, _):
      return .get
    }
  }
  
}
