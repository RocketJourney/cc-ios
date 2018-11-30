//
//  MenuViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/27/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var clubLabel: UILabel!
  @IBOutlet weak var ownerButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupView()
    self.dataFromServer()
  }
  
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.navigationController?.navigationBar.isHidden = true
    
    self.nameLabel.font = UIFont.montserratBold(23)
    self.nameLabel.textColor = UIColor.white
    self.nameLabel.text = "Name"
    
    self.clubLabel.font = UIFont.montserratBold(16)
    self.clubLabel.textColor = UIColor(hex: 0xbebebe)
    self.clubLabel.text = "Club"
    
    self.headerView.backgroundColor = UIColor(hex: 0x5a5a5a)
    
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.backgroundColor = UIColor(hex: 0x4a4a4a)
    self.tableView.register(UINib(nibName: "MenuSpotCell", bundle: nil), forCellReuseIdentifier: "kMenuSpotCell")    
  }
  
  
  
  private func dataFromServer() -> Void {
    
    
    if self.isNetworkReachable(){
      User.current?.getSpotsFromClub((User.current?.currentClub?.id)!, completion: {
        self.tableView.reloadData()
        self.nameLabel.text = User.current?.fullName
        self.clubLabel.text = User.current?.currentClub?.name
      }, error: { (error) in
        self.internalServerError()
      })
    }else{
      self.noInternetAlert()
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (User.current?.currentClub?.accesibleSpots.count)!
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kMenuSpotCell") as! MenuSpotCell
    let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
    cell.spotNameLabel.text = spot?.branchName
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }
}
