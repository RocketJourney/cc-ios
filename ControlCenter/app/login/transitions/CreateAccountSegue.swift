//
//  CreateAccountSegue.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class CreateAccountSegue: UIStoryboardSegue {
  override func perform() {
    let checkEmailViewController = source as! CheckEmailViewController
    let createAccountViewController = destination as! CreateAccountViewController
    createAccountViewController.emailString = checkEmailViewController.email?.text
    createAccountViewController.invitationCode = checkEmailViewController.invitationCode
    checkEmailViewController.navigationController?.pushViewController(createAccountViewController, animated: true)
  }
}
