//
//  PreludeChooseClubSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/20/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class PreludeChooseClubSegue: UIStoryboardSegue {
  override func perform() {
    let preludeViewController = source as! PreludeViewController
    let chooseClubViewController = destination as! ChooseClubViewController
    let nav = UINavigationController(rootViewController: chooseClubViewController)
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.barTintColor = UIColor(hex:0x333333)!    
    preludeViewController.present(nav, animated: true, completion: nil)
  }
}
