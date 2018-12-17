//
//  Data+extensions.swift
//  ControlCenter
//
//  Created by Erik on 12/7/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation

extension Data {
  
  func hexEncodedString() -> String {
    return map { String(format: "%02hhx", $0) }.joined()
  }
  
}
