//
//  LoginRouter.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import Alamofire

enum LoginRouter: URLRequestConvertible {
  case login(String, String)
  case signUp(String, String, String, String, String)
  case recoverPassword(String)
  
  
  func asURLRequest() throws -> URLRequest {
    var urlRequest = RequestBuilderV2.build(path, method: method)
    
    switch self {
    case .login(let email, let password):
      let encoding = Alamofire.JSONEncoding.default
      let params = ["email" : email, "password": password]
      urlRequest = try encoding.encode(urlRequest, with: params)
    case .signUp(let email, let name, let lastName, let password, let invitationCode):
      let user = ["email" : email, "password": password, "first_name" : name, "last_name" : lastName]
      let params = ["user" : user, "invitation" : invitationCode] as [String : Any]
      let encoding = Alamofire.JSONEncoding.default
      urlRequest = try encoding.encode(urlRequest, with: params)
    case .recoverPassword(let email):
      let params = ["email" : email]
      let encoding = Alamofire.JSONEncoding.default
      urlRequest = try encoding.encode(urlRequest, with: params)
    }
    return urlRequest
  }
  
  
  var method: HTTPMethod {
    switch self {
    case .login(_, _), .signUp(_), .recoverPassword(_):
      return .post
    }
  }
  
  
  var path: String {
    switch self {
    case .login(_, _):
      return "/sessions"
    case .signUp(_, _, _, _, _):
      return "/users"
    case .recoverPassword(_):
      return "/users/passwords"
    }
  }
}
