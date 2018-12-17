//
//  UIBarButtonItem+extension.swift
//  ControlCenter
//
//  Created by Erik on 12/12/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
  
  var frame: CGRect? {
    guard let view = self.value(forKey: "view") as? UIView else {
      return nil
    }
    return view.frame
  }
}
