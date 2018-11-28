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
  
  case getSpotsFromClub(clubId: Int)
  
  func asURLRequest() throws -> URLRequest {
    
    let urlRequest = RequestBuilderV2.build(path, method: method)
    switch self {
      
    case .getSpotsFromClub(clubId: <#T##Int#>):
      break
    default:
      break
    }
    
    return urlRequest
  }
  
  
  var path: String {
    switch self {
    case .getSpotsFromClub(let clubId):
      return "/clubs/\(clubId)/spots"    
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSpotsFromClub(_):
      return .get
    }
  }
  
}
