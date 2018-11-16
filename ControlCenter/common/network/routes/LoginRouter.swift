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
  
  
  func asURLRequest() throws -> URLRequest {
    var urlRequest = RequestBuilderV2.build(path, method: method)
    
    switch self {
    case .login(let email, let password):
      let encoding = Alamofire.JSONEncoding.default
      let params = ["email" : email, "password": password]
      urlRequest = try encoding.encode(urlRequest, with: params)    
    }
    return urlRequest
  }
  
  
  var method: HTTPMethod {
    switch self {
    case .login(_, _):
      return .post
    }
  }
  
  
  var path: String {
    switch self {
    case .login(_, _):
      return "/sessions"
    
    }
  }
}
