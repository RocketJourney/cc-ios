//
//  UsersViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/26/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()    
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x212121)
  }
}
