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
  func logout()
  func topLocations()
}

class HomeViewController: UITabBarController, SpotSelectionDelegate {
  
  var club: Club?
  var titleViewCache: UIView?
  var titleLabel: UILabel?
  
  
  var menuButton: UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.displayTitle()
  }
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x1a1a1a)    
    self.setupMenu()
    self.setupMenuButton()
    self.displayTitle()
    self.tabBar.barTintColor = UIColor(hex: 0x333333)
    self.tabBar.backgroundColor = UIColor(hex: 0x333333)
  }
  
  @objc func logoutAction() -> Void {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      realm.deleteAll()
    }
    self.performSegue(withIdentifier: "kHomePreludeSegue", sender: nil)
    
  }
  
  
  func titleView(_ badgeUrl:String, name:String)->UIView {
    
    let xview = UIView()
    let imgView = UIImageView()
    imgView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
    imgView.layer.masksToBounds = true
    imgView.layer.cornerRadius = AppDelegate.ratioImages * imgView.frame.height
    imgView.sd_setImage(with: URL(string: badgeUrl))
    xview.addSubview(imgView)
    self.titleLabel = UILabel()
    self.titleLabel!.text = name
    self.titleLabel!.font = UIFont.montserratBold(18)
    self.titleLabel!.textColor = UIColor.white
    self.titleLabel!.sizeToFit()
    self.titleLabel!.center = CGPoint(x: 36 + (self.titleLabel!.frame.size.width / 2), y: 14)
    xview.addSubview(self.titleLabel!)
    titleViewCache = xview
    xview.frame = CGRect(x: 0, y: 0, width: 36 + self.titleLabel!.frame.size.width, height: 28)
    return xview
    
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
      User.current?.selectedSpot?.paginator = nil
      User.current?.selectedSpot?.assistants = List<UserAssistant>()
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
        usersVC?.setupReachBottom()
        usersVC?.getDataFromServer()
      }
    }
    self.viewDidAppear(false)
  }
  
  func logout() {
    self.logoutAction()
  }
  
  func topLocations() {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      let userModel = User.current
      userModel?.selectedSpot = nil
      User.current?.selectedSpot = nil
      User.current?.currentClub?.assistants = List<UserAssistant>()
      User.current?.currentClub?.paginator = nil
      realm.create(User.self, value: userModel!, update: true)
    }
    self.displayTitle()
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
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      
      let userModel = User.current
      userModel?.selectedSpot = User.current?.selectedSpot
      if userModel?.selectedSpot != nil {
        let spot = userModel?.selectedSpot
        spot?.assistants = List<UserAssistant>()
        spot?.paginator = nil
        realm.create(Spot.self, value: spot!, update: true)
        userModel?.selectedSpot = spot
        User.current?.selectedSpot!.assistants = List<UserAssistant>()
        User.current?.selectedSpot?.paginator = nil
      }else {
        if User.current != nil && User.current?.currentClub != nil {
          let club = User.current?.currentClub
          
          userModel?.currentClub?.assistants = List<UserAssistant>()
          userModel?.currentClub?.paginator = nil
          
          club?.assistants = List<UserAssistant>()
          club?.paginator = nil
          
          userModel?.currentClub = club
          
          realm.create(Club.self, value: club!, update: true)
          userModel?.currentClub = club
          
          User.current?.currentClub?.assistants = List<UserAssistant>()
          User.current?.currentClub?.paginator = nil
          realm.create(User.self, value: User.current!, update: true)
        }
      }
      
      realm.create(User.self, value: userModel!, update: true)
    }
    
    if item == (tabBar.items)![0]{
      //Do something if index is 0
      NSLog("item 0")
      self.selectedIndex = 0
      let dashboardVC = self.viewControllers?[0] as? DashboardViewController
      if dashboardVC != nil {
        dashboardVC!.getDataFromServer()
      }
      
    }else if item == (tabBar.items)![1]{      
      NSLog("item 1")
      self.selectedIndex = 1
      let usersVC = self.viewControllers?[1] as? UsersViewController
      if usersVC != nil {
        usersVC?.getDataFromServer()
      }
    }
  }
  
  
  private func displayTitle() -> Void {
    if User.current != nil {
      if User.current?.selectedSpot != nil{
        self.navigationItem.titleView = self.titleView((User.current?.currentClub?.logoUrl)!, name: (User.current?.selectedSpot?.branchName)!)
      }else {
        if User.current?.permission == "owner"{
          self.navigationItem.titleView = self.titleView((User.current?.currentClub?.logoUrl)!, name: "ALL_LOCATIONS".localized)
        }else if User.current?.permission == "some_spots"{
          self.navigationItem.titleView = self.titleView((User.current?.currentClub?.logoUrl)!, name: "ALL_MY_LOCATIONS".localized)
        }
      }
    }
  }
  
  
  
  
}
