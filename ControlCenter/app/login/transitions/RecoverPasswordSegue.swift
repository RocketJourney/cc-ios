//
//  RecoveryPasswordSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit


class RecoverPasswordSegue: UIStoryboardSegue {
  override func perform() {
    let loginViewController = source as! LoginViewController
    let recoverPasswordViewController = destination as! RecoverPasswordViewController    
    loginViewController.navigationController?.pushViewController(recoverPasswordViewController, animated: true)
  }
}
