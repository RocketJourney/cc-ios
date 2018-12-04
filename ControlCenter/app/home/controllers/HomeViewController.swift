//
//  HomeViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/19/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import RealmSwift
import SideMenu

protocol SpotSelectionDelegate {
  func spotSelected(spot: Spot)
}

class HomeViewController: UITabBarController, SpotSelectionDelegate {
  
  var club: Club?
  var titleViewCache: UIView?
  
  
  var menuButton: UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)
    let clubModel = User.current?.currentClub
    self.navigationItem.titleView = self.titleView((clubModel?.logoUrl)!, name: (clubModel?.name)!)
    self.setupMenu()
    self.setupMenuButton()
    self.tabBar.barTintColor = UIColor(hex: 0x333333)
    self.tabBar.backgroundColor = UIColor(hex: 0x333333)
  }
  
  @objc func logoutAction() -> Void {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      realm.deleteAll()
    }
    self.dismissView()    
    NotificationCenter.default.post(name: NSNotification.Name("showIntroViewController"), object: nil)
    
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
  
  
  private func setupMenu() -> Void {
    let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
    menuViewController.spotSelectedDelegate = self
    SideMenuManager.default.menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuViewController)
    SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
    SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: (self.navigationController?.view)!)
    SideMenuManager.default.menuFadeStatusBar = false
    SideMenuManager.default.menuWidth = self.view.frame.width - 50
    
    
  }
  
  private func setupMenuButton() -> Void {
    self.menuButton = UIBarButtonItem(image: UIImage(named:"side-menu"), style: .plain, target: self, action: #selector(self.showMenu))
    self.navigationItem.leftBarButtonItem = self.menuButton
    self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: 0x7a7a7a)
  }
  
  @objc private func showMenu() -> Void {
    self.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
  }
  
  @objc private func dismissMenu() -> Void{
    self.dismiss(animated: true, completion: nil)
  }
  
  
  func spotSelected(spot: Spot) {
    NSLog("spot =======> %@", spot)
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      spot.assistants = List<UserAssistant>()
      let userModel = User.current
      userModel?.selectedSpot = spot
      realm.create(User.self, value: userModel!, update: true)
    }
    
    if self.selectedIndex == 0 {
      let dashboardVC = self.viewControllers?[0] as? DashboardViewController
      if dashboardVC != nil {        
        dashboardVC!.getDataFromServer()
      }
    }else {
      let usersVC = self.viewControllers?[1] as? UsersViewController
      if usersVC != nil {
        usersVC?.getDataFromServer()
      }
    }
    
    
    
    
  }
  
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item == (tabBar.items)![0]{
      //Do something if index is 0
      NSLog("item 0")
      self.selectedIndex = 0
    }
    else if item == (tabBar.items)![1]{
      NSLog("item 1")
      self.selectedIndex = 1
    }
  }
  
  
  
  

}
