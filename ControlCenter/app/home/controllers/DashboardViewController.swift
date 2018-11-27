//
//  DashboardViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/26/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
  
  @IBOutlet weak var barItem: UITabBarItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    // Do any additional setup after loading the view.
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x212121)
    self.view.backgroundColor = UIColor.rocketYellow()
    
    self.barItem = UITabBarItem(title: "DASHBOARD".localized, image: nil, selectedImage: nil)
  }
  
}
