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
  
  var spotSelectedDelegate: SpotSelectionDelegate?
  
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
    
    if User.current != nil {
      if (User.current?.permission == "owner" || User.current?.permission == "all_spots" || User.current?.permission == "some_spots") && (User.current?.currentClub?.accesibleSpots.count)! > 1 {
        return 3
      }else{
        return 2
      }
    }else{
      return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if User.current != nil {
      if (User.current?.permission == "owner" || User.current?.permission == "all_spots" || User.current?.permission == "some_spots") && (User.current?.currentClub?.accesibleSpots.count)! > 1 {
        switch section {
        case 0:
          return 1
        case 1:
          return (User.current?.currentClub?.sortedSpotsBranchName.count)!
        default:
          return 3
        }
      }else {
        switch section {
        case 0:
          return (User.current?.currentClub?.sortedSpotsBranchName.count)!
        default:
          return 3
        }
      }
    }else{
      return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "kMenuSpotCell") as! MenuSpotCell
    
    if (User.current?.permission == "owner" ||
      User.current?.permission == "all_spots" ||
      User.current?.permission == "some_spots") && (User.current?.currentClub?.accesibleSpots.count)! > 1 {
      switch indexPath.section {
      case 0:
        if User.current?.permission == "owner" || User.current?.permission == "all_spots" {
          cell.spotNameLabel?.text = "ALL_LOCATIONS".localized
        }else if User.current?.permission == "some_spots" {
          cell.spotNameLabel?.text = "ALL_MY_LOCATIONS".localized
        }
      case 1:
        if User.current?.currentClub != nil {
          let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
          cell.spotNameLabel?.text = spot?.branchName
        }
      default:
        switch indexPath.row {
        case 0:
          cell.spotNameLabel.text = "TERMS_OF_SERVICE".localized
        case 1:
          cell.spotNameLabel.text = "PRIVACY_POLICY".localized
        default:
          cell.spotNameLabel.text = "LOG_OUT".localized
        }
      }
    }else{
      switch indexPath.section {
      case 0:
        if User.current?.currentClub != nil {
          let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
          cell.spotNameLabel?.text = spot?.branchName
        }
      default:
        switch indexPath.row {
        case 0:
          cell.spotNameLabel.text = "TERMS_OF_SERVICE".localized
        case 1:
          cell.spotNameLabel.text = "PRIVACY_POLICY".localized
        default:
          cell.spotNameLabel.text = "LOG_OUT".localized
        }
      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (User.current?.permission == "owner" ||
      User.current?.permission == "all_spots" ||
      User.current?.permission == "some_spots") && (User.current?.currentClub?.accesibleSpots.count)! > 1 {
      switch indexPath.section {
      case 0:
        self.spotSelectedDelegate?.topLocations()
        self.dismissView()
      case 1:
        let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
        self.spotSelectedDelegate?.spotSelected(spot: spot!)
        self.dismissView()
      default:
        switch indexPath.row {
        case 0:
          break
        case 1:
          break
        default:
          self.dismissView()
          self.spotSelectedDelegate?.logout()
        }
      }
    }else{
      switch indexPath.section {
      case 0:
        let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
        self.spotSelectedDelegate?.spotSelected(spot: spot!)
        self.dismissView()
      default:
        self.dismissView()
        self.spotSelectedDelegate?.logout()
      }
    }
    
  }
  
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UINib(nibName: "FooterSeparatorView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! FooterSeparatorView
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 10
  }
  
  
}
