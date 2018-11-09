//
//  LoginViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    
    // Do any additional setup after loading the view.
  }
  
  @objc func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x313131)
    self.backCross()
    self.title = "LOGIN".localized
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
