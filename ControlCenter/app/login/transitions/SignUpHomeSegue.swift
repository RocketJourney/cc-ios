//
//  SignUpHomeSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class SignUpHomeSegue: UIStoryboardSegue {
  override func perform() {
    let createAccountViewController = source as! CreateAccountViewController
    let homeViewController = destination as! HomeViewController
    let nav = UINavigationController(rootViewController: homeViewController)
    nav.navigationBar.isHidden = true
    createAccountViewController.present(nav, animated: true, completion: nil)
  }
}
