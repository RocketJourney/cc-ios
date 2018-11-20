//
//  HomeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
  @IBOutlet weak var logotuButton: UIButton!
  var club: Club?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.title = "HOME"
    self.logotuButton.addTarget(self, action: #selector(self.logoutAction), for: .touchUpInside)
    // Do any additional setup after loading the view.
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)
  }
  
  @objc func logoutAction() -> Void {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      realm.deleteAll()
    }
    self.dismissView()    
    NotificationCenter.default.post(name: NSNotification.Name("showIntroViewController"), object: nil)
    
  }
  
  
}
