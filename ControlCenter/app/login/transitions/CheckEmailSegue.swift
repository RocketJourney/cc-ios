//
//  CheckEmailSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/16/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class CheckEmailSegue: UIStoryboardSegue {
  override func perform() {
    let preludeViewController = source as! PreludeViewController
    let checkEmailViewController = destination as! CheckEmailViewController
    checkEmailViewController.invitationCode = preludeViewController.invitationConde
    let nav = UINavigationController(rootViewController: checkEmailViewController)
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.barTintColor = UIColor(hex:0x333333)!
    preludeViewController.present(nav, animated: true, completion: nil)
  }
}
