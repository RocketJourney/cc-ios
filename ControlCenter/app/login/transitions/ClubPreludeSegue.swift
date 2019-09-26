//
//  ClubPreludeSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/25/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class ClubPreludeSegue: UIStoryboardSegue {
  override func perform() {
    
    let chooseClubViewController = source as! ChooseClubViewController
    let preludeViewController = destination as! PreludeViewController
    let nav = UINavigationController(rootViewController: preludeViewController)
    nav.navigationBar.isHidden = true
    nav.modalPresentationStyle = .fullScreen
    chooseClubViewController.present(nav, animated: true, completion: nil)
  }
}
