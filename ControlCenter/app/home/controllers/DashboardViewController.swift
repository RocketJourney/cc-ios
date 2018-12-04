//
//  DashboardViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/26/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var barItem: UITabBarItem!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var viewLocationLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.getDataFromServer()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
      
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.printData()
    
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x212121)
    
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.separatorColor = UIColor.clear
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "kStatusCell")
    self.tableView.tableFooterView = UIView()
    
    
    self.barItem = UITabBarItem(title: "DASHBOARD".localized, image: UIImage(named: "dashboard-icon"), selectedImage: nil)
    self.barItem.badgeColor = UIColor(hex: 0x333333)
    
    
    self.viewLocationLabel.font = UIFont.montserratRegular(15)
    self.viewLocationLabel.textColor = UIColor(hex: 0x9a9a9a)
        
  }
  
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kStatusCell") as! StatusCell
    if User.current != nil && User.current?.selectedSpot != nil {
      if indexPath.row == 0 {
        cell.counterStatusLabel.text = "\(User.current?.selectedSpot?.totalUsersCheckedIn ?? 0)"
        cell.textStatusLabel.text = "USERS_CHECKED_IN".localized
      }else if indexPath.row == 1 {
        cell.counterStatusLabel.text = "\(User.current?.selectedSpot?.totalUsersWithTeam ?? 0)"
        cell.textStatusLabel.text = "USERS_WITH_TEAM".localized
      }
    }else{
      if let club = User.current?.currentClub {
        if indexPath.row == 0 {
          cell.counterStatusLabel.text = String(club.totalUsersCheckedIn)
          cell.textStatusLabel.text = "USERS_CHECKED_IN".localized
        }else if indexPath.row == 1 {
          cell.counterStatusLabel.text = String(club.totalUsersWithTeam)
          cell.textStatusLabel.text = "USERS_WITH_TEAM".localized
        }
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
  func getDataFromServer() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      self.getSpotDataFromServer()
    }else {
      self.getClubDataFromServer()
    }
  }
  
  private func getClubDataFromServer() -> Void {
    if self.isNetworkReachable(){
      self.tableView.isHidden = true
      self.showActivityIndicator()
      User.current?.getClubStatus(clubId: (User.current?.currentClub?.id)!, completion: {
        self.hideActivityIndicator()
        self.tableView.isHidden = false
        self.printData()
      }, error: { (error) in
        self.hideActivityIndicator()
        self.tableView.isHidden = false
        if let error = error as? NSError {
          if error.code == 500 {
            self.internalServerError()
          }
        }
      })
      
    }else {
      self.noInternetAlert()
    }
  }
  
  
  private func getSpotDataFromServer() -> Void {
    if self.isNetworkReachable(){
      self.tableView.isHidden = true
      self.showActivityIndicator()
      User.current?.getSpotStatus(clubId: (User.current?.selectedSpot?.clubId)!, spotId: (User.current?.selectedSpot?.id)!, completion: {
        self.tableView.isHidden = false
        self.hideActivityIndicator()
        self.printData()
      }, error: { (error) in
        self.tableView.isHidden = false
        self.hideActivityIndicator()
        if let error = error as? NSError {
          if error.code == 500 {
            self.internalServerError()
          }
        }
      })
    }else {
      
    }
  }
  
  private func printData() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      self.printSpotData()
    }else {
      self.printClubData()
    }
  }
  
  private func printClubData() -> Void {
    self.tableView.reloadData()
  }
  
  private func printSpotData() -> Void {
    self.tableView.reloadData()
  }
  
  
  private func showActivityIndicator() -> Void {
    self.activityIndicator.startAnimating()
    self.activityIndicator.isHidden = false
  }
  
  private func hideActivityIndicator() -> Void {
    self.activityIndicator.stopAnimating()
    self.activityIndicator.isHidden = true
  }
}
