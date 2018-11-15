//
//  PreludeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/15/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class PreludeViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    // Do any additional setup after loading the view.
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.performSegue(withIdentifier: "kIntroSegue", sender: nil)
    }
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor.rocketYellow()
    self.activityIndicator.startAnimating()
    
  }
  
  
  
}
