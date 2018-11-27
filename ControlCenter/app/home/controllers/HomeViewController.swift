//
//  HomeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UITabBarController {
  
  var club: Club?
  var titleViewCache: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    //self.logotuButton.addTarget(self, action: #selector(self.logoutAction), for: .touchUpInside)
    // Do any additional setup after loading the view.
    //self.createTabBarController()
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)
    self.navigationItem.titleView = self.titleView((self.club?.logoUrl)!, name: (self.club?.name)!)
  }
  
  @objc func logoutAction() -> Void {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      realm.deleteAll()
    }
    self.dismissView()    
    NotificationCenter.default.post(name: NSNotification.Name("showIntroViewController"), object: nil)
    
  }
  
  
  private func createTabBarController() -> Void {
    let tabBarViewController = UITabBarController()
    tabBarViewController.tabBar.tintColor = UIColor.rocketYellow()
    tabBarViewController.tabBar.isTranslucent = false
    tabBarViewController.tabBar.backgroundColor = UIColor(hex: 0x1a1a1a)
    
    let dashboardViewController = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
    dashboardViewController.tabBarItem = UITabBarItem(title: "dashboard", image: nil, tag: 0)
    
    
    
    
    
    let usersViewController = UsersViewController(nibName: "DashboardViewController", bundle: nil)
    usersViewController.tabBarItem = UITabBarItem(title: "users", image: nil, tag: 1)
    
    let controllersArray = [dashboardViewController, usersViewController]
    tabBarViewController.viewControllers = controllersArray.map{ UINavigationController(rootViewController: $0) }
    self.view.addSubview(tabBarViewController.view)
  }
  
  
  
  func titleView(_ badgeUrl:String, name:String)->UIView {
    if let titleViewCache = self.titleViewCache {
      return titleViewCache
    } else {
      let xview = UIView()
      let imgView = UIImageView()
      imgView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
      imgView.layer.masksToBounds = true
      imgView.layer.cornerRadius = AppDelegate.ratioImages * imgView.frame.height
      imgView.sd_setImage(with: URL(string: badgeUrl))
      xview.addSubview(imgView)
      let lbl = UILabel()
      lbl.text = name
      lbl.font = UIFont.montserratBold(18)
      lbl.textColor = UIColor.white
      lbl.sizeToFit()
      lbl.center = CGPoint(x: 36 + (lbl.frame.size.width / 2), y: 14)
      xview.addSubview(lbl)
      titleViewCache = xview
      xview.frame = CGRect(x: 0, y: 0, width: 36 + lbl.frame.size.width, height: 28)
      return xview
    }
  }
  
  
}
