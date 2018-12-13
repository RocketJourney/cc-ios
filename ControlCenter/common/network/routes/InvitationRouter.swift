//
//  InvitationRouter.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import Alamofire

enum InvitationRouter: URLRequestConvertible {
  case validateInvitation(String)
  case validateInvitationWithEmail(String, String)
  case createInvitation([String: Any])
  
  func asURLRequest() throws -> URLRequest {
    var urlRequest = RequestBuilderV2.build(path, method: method)
    
    switch self {
    case .validateInvitation(_):
      break
    case .validateInvitationWithEmail(_, _):
      break
    case .createInvitation(let params):
      let encoding = Alamofire.JSONEncoding.default
      urlRequest = try encoding.encode(urlRequest, with: ["invitation" : params])
      break
    }
    return urlRequest
  }
  
  
  var method: HTTPMethod {
    switch self {
    case .validateInvitation(_), .validateInvitationWithEmail(_, _):
      return .get
    case .createInvitation(_):
      return .post
    }
  }
  
  
  var path: String {
    switch self {
    case .validateInvitation(let invitationCode):
      return "/invites/\(invitationCode)"
    case .validateInvitationWithEmail(let invitationCode, let email):
      return "/invites/\(invitationCode)/email/\(email)"
    case .createInvitation(_):
      return"invites"
    }
  }
}
