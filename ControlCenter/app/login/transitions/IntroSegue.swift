//
//  IntroSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class IntroSegue: UIStoryboardSegue {
  
  override func perform() {
//    let preludeViewController = source as! PreludeViewController
//    let introViewController = destination as! IntroViewController
//    let nav = UINavigationController(rootViewController: introViewController)
//    preludeViewController.present(nav, animated: true, completion: nil)
//    nav.navigationBar.isHidden = false
    
    
    let preludeViewController = source as! PreludeViewController
    let introviewControler = destination as! IntroViewController
    let nav = UINavigationController(rootViewController: introviewControler)
    nav.navigationBar.isHidden = true
    preludeViewController.present(nav, animated: true, completion: nil)
  }
}
