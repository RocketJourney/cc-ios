//
//  LoginSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class LoginSegue: UIStoryboardSegue {
  override func perform() {
    let introViewController = source as! IntroViewController
    let loginViewController = destination as! LoginViewController
    let nav = UINavigationController(rootViewController: loginViewController)
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.barTintColor = UIColor(hex:0x333333)!
    nav.modalPresentationStyle = .fullScreen
    introViewController.present(nav, animated: true, completion: nil)
  }

}
