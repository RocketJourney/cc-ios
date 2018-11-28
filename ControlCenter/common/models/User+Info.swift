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
        completion()
      }else{
        error(NSError(domain: "request error", code: response.response?.statusCode ?? 500, userInfo: nil))
      }
    }
    
  }
  
}
