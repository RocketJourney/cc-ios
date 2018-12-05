//
//  ChooseClubSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class ChooseClubSegue: UIStoryboardSegue {
  override func perform() {
    let loginViewController = source as! LoginViewController
    let chooseClubViewController = destination as! ChooseClubViewController
    let nav = UINavigationController(rootViewController: chooseClubViewController)
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.barTintColor = UIColor(hex:0x333333)!
    loginViewController.present(nav, animated: true, completion: nil)
  }
}
