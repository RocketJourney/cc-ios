//
//  PreludeHomeSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/20/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class PreludeHomeSegue: UIStoryboardSegue {
  override func perform() {
    let preludeViewController = source as! PreludeViewController
    let homeViewController = destination as! HomeViewController
    if User.current?.currentClub != nil {
      homeViewController.club = User.current?.currentClub
    }
    let nav = UINavigationController(rootViewController: homeViewController)
    nav.navigationBar.isHidden = true
    preludeViewController.present(nav, animated: true, completion: nil)
  }
}
