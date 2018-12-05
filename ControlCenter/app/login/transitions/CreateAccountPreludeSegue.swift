//
//  CreateAccountPreludeSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/25/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class CreateAccountPreludeSegue: UIStoryboardSegue {
  override func perform() {
    
    let createAccountViewController = source as! CreateAccountViewController
    let preludeViewController = destination as! PreludeViewController
    let nav = UINavigationController(rootViewController: preludeViewController)
    nav.navigationBar.isHidden = true
    createAccountViewController.present(nav, animated: true, completion: nil)
  }
}
