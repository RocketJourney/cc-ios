//
//  HomePreludeSegue.swift
//  ControlCenter
//
//  Created by Erik on 12/3/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class HomePreludeSegue: UIStoryboardSegue {

  override func perform() {
    let homeViewController = source as! HomeViewController
    let preludeViewController = destination as! PreludeViewController
    let nav = UINavigationController(rootViewController: preludeViewController)
    nav.navigationBar.isHidden = true
    homeViewController.present(nav, animated: true, completion: nil)
  }
}
