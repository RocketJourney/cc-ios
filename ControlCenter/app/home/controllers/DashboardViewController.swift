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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x212121)
    
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.separatorColor = UIColor.clear
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "kStatusCell")
    self.tableView.tableFooterView = UIView()
    
    self.barItem = UITabBarItem(title: "DASHBOARD".localized, image: nil, selectedImage: nil)
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
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
  private func getDataFromServer() -> Void {
    if self.isNetworkReachable(){
      
      User.current?.getSpotStatus(clubId: (User.current?.currentClub?.id)!, completion: {
        <#code#>
      }, error: { (error) in
        <#code#>
      })
      
    }else {
      self.noInternetAlert()
    }
  }
  
  private func printData() -> Void {
    
  }
  
}
