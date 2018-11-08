//
//  IntroViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/8/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  
  @IBOutlet weak var alReadyAccountLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var dontHaveAccountLabel: UILabel!
  @IBOutlet weak var createAccountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    
    
    // Do any additional setup after loading the view.
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)
    self.alReadyAccountLabel.font = UIFont.montserratRegular(18)
    self.alReadyAccountLabel.textColor = UIColor(hex: 0xb3b3b3)
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
