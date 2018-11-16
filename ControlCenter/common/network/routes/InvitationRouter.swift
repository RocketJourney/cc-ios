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
  
  
  func asURLRequest() throws -> URLRequest {
    let urlRequest = RequestBuilderV2.build(path, method: method)
    
    switch self {
    case .validateInvitation(_):
      break
    case .validateInvitationWithEmail(_, _):
      break
    }
    return urlRequest
  }
  
  
  var method: HTTPMethod {
    switch self {
    case .validateInvitation(_), .validateInvitationWithEmail(_, _):
      return .get
    }
  }
  
  
  var path: String {
    switch self {
    case .validateInvitation(let invitationCode):
      return "/invites/\(invitationCode)"
    case .validateInvitationWithEmail(let invitationCode, let email):
      return "/invites/\(invitationCode)?email=\(email)"
    }
  }
}
