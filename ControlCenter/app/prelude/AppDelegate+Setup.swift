//
//  AppDelegate+Setup.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

import Crashlytics
import Fabric

extension AppDelegate {
  
  static let ratioImages: CGFloat = 0.286
  
  func initialSetup() -> Void {
    Fabric.with([Crashlytics.self])
    
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.montserratBold(18), NSAttributedString.Key.foregroundColor : UIColor.white]
  }
}
