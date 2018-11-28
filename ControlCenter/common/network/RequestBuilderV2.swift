//
//  RequestBuilderV2.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import Alamofire

class RequestBuilderV2 {
  
  #if DEBUG
  static let baseURL = "https://api.testin.space/api/v2"
  #elseif RELEASE
  static let baseURL = "https://api.testin.space/api/v2"
  #endif
  
  
  static func build(_ path: String, method: HTTPMethod) -> URLRequest {
    
    var url = Foundation.URL(string: baseURL)!
    url.appendPathComponent(path)
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    if let token = User.current?.token {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
    }
    
    return request
  }
  
}
