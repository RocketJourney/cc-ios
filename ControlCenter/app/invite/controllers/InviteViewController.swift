//
//  InviteViewController.swift
//  ControlCenter
//
//  Created by Erik on 12/11/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var titleLabel: UILabel!
  
  
  
  var customNextButton: UIButton?
  var backButton: UIBarButtonItem?
  var nextButton: UIBarButtonItem?
  var activityIndicator: UIActivityIndicatorView?
  
  var params:[String: Any] = [String : Any]()
  
  var spots:Set<Int> = Set<Int>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  
  private func setupView() -> Void {
    
    self.title = "INVITE_COLLEAGUE".localized
    self.view.backgroundColor = UIColor(hex: 0x212121)
    self.tableView.backgroundColor = UIColor.clear
    
    self.titleLabel.font = UIFont.montserratRegular(15)
    self.titleLabel.textColor = UIColor(hex: 0x9a9a9a)
    self.titleLabel.text = "SELECT_LOCATIONS_INVITE".localized
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "InviteCell", bundle: nil), forCellReuseIdentifier: "kInviteCell")
    
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorColor = UIColor(hex: 0x212121)
    
    
    self.backButton = UIBarButtonItem(image: UIImage(named:"cross-image"), style: .plain, target: self, action: #selector(self.dismissView))
    self.navigationItem.leftBarButtonItem = self.backButton
    
    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.rocketYellow()
    
    self.activityIndicator = UIActivityIndicatorView(style: .white)
    
    self.customNextButton = UIButton()
    self.customNextButton?.titleLabel?.font = UIFont.montserratBold(18)
    self.customNextButton?.setTitle("NEXT".localized, for: .normal)
    self.customNextButton?.setTitleColor(UIColor.rocketYellow(), for: .normal)
    self.customNextButton?.setTitleColor(UIColor.rocketGrayChat(), for: .highlighted)
    self.customNextButton?.setTitleColor(UIColor.rocketGrayChat(), for: .selected)
    self.customNextButton?.setTitleColor(UIColor.rocketGrayChat(), for: .disabled)
    
    self.customNextButton!.addTarget(self, action: #selector(self.createInvitation), for: .touchUpInside)
    self.customNextButton!.addSubview(self.activityIndicator!)
    
    self.nextButton = UIBarButtonItem(customView: customNextButton!)
    self.navigationItem.rightBarButtonItem = self.nextButton
    
    self.hideActivityIndicator()
    self.customNextButton?.isEnabled = false
    
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.activityIndicator?.center = CGPoint(x: ((self.customNextButton?.frame.width)! - ((self.activityIndicator?.frame.width)!) / 2), y: (self.customNextButton?.center.y)!)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    if User.current != nil{
      if User.current?.permission != nil{
        switch User.current?.permission {
        case "some_spots":
          return 1
        default:
          if User.current?.currentClub != nil && (User.current?.currentClub?.accesibleSpots.count)! > 0{
            return 2
          }else{
            return 0
          }
        }
      }else{
        return 0
      }
    }else{
      return 0
    }
    
  }
  
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 6
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = UIColor(hex: 0x212121)
    return view
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if User.current != nil{
      if User.current?.permission != nil{
        switch User.current?.permission {
        case "some_spots":
          if section == 0{
            return (User.current?.currentClub?.accesibleSpots.count)!
          }else{
            return 0
          }
        default:
          if section == 0 {
            return 1
          }else {
            return (User.current?.currentClub?.accesibleSpots.count)!
          }
        }
      }else{
        return 0
      }
    }else{
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if User.current != nil{
      if User.current?.permission != nil{
        switch User.current?.permission {
        case "some_spots":
          let cell = tableView.dequeueReusableCell(withIdentifier: "kInviteCell") as! InviteCell
          let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
          cell.inviteLabel.text = spot?.branchName
          return cell
        default:
          if User.current?.currentClub != nil && (User.current?.currentClub?.accesibleSpots.count)! > 0{
            if indexPath.section == 0{
              let cell = tableView.dequeueReusableCell(withIdentifier: "kInviteCell") as! InviteCell
              cell.inviteLabel.text = "ALL_LOCATIONS".localized
              return cell
            }else if indexPath.section == 1{
              let cell = tableView.dequeueReusableCell(withIdentifier: "kInviteCell") as! InviteCell
              let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
              cell.inviteLabel.text = spot?.branchName
              return cell
            }
          }else{
            return UITableViewCell()
          }
        }
      }else{
        return UITableViewCell()
      }
    }else{
      return UITableViewCell()
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView.numberOfSections == 2 {
      if indexPath.section == 0 {
        let cell = tableView.cellForRow(at: indexPath)
        self.selectCells(sender: cell!)
      }else if indexPath.section == 1{
        let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
        self.spots.insert((spot?.id)!)
      }
    }else{
      let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
      self.spots.insert((spot?.id)!)
    }
    self.validateData()
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if tableView.numberOfSections == 2{
      if indexPath.section == 0{
        let cell = tableView.cellForRow(at: indexPath)
        self.selectCells(sender: cell!)
      }else if indexPath.section == 1{
        let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
        self.spots.remove((spot?.id)!)
        if let allLocationsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)){
          if (allLocationsCell.isSelected) {
            self.tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
          }
        }
        
      }else{
        if let allLocationsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)){
          if (allLocationsCell.isSelected) {
            self.tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
          }
        }
        
      }
    }else { // some_spots
      let spot = User.current?.currentClub?.sortedSpotsBranchName[indexPath.row]
      self.spots.remove((spot?.id)!)
    }
    self.validateData()
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
  @objc private func createInvitation() -> Void {
    NSLog("create invite")
    
    if self.isNetworkReachable(){
      self.showActivityIndicator()
      self.customNextButton?.isHidden = false
      self.customNextButton?.setTitle("".localized, for: .normal)
      self.backButton?.isEnabled = false
      self.tableView.isUserInteractionEnabled = false
      self.tableView.isOpaque = true
      User.current?.createInvitation(self.params, completion: { (link) in
        self.hideActivityIndicator()
        self.customNextButton?.isHidden = false
        self.customNextButton?.setTitle("NEXT".localized, for: .normal)
        self.backButton?.isEnabled = true
        self.tableView.isUserInteractionEnabled = true
        self.tableView.isOpaque = false
        let sendLinkController = SendLinkViewController(nibName: "SendLinkViewController", bundle: nil)
        sendLinkController.linkShare = link
        self.navigationController?.pushViewController(sendLinkController, animated: true)
      }, error: { (error) in
        self.hideActivityIndicator()
        self.customNextButton?.isHidden = false
        self.customNextButton?.setTitle("NEXT".localized, for: .normal)
        self.backButton?.isEnabled = true
        self.tableView.isUserInteractionEnabled = true
        self.tableView.isOpaque = false
        if let error = error as? NSError {
          if error.code == 500 {
            self.internalServerError()
          }
        }
      })
    }
    
    
  }
  
  
  @objc private func selectCells(sender: UITableViewCell) -> Void {
    let totalRows = self.tableView.numberOfRows(inSection: 1)
    for row in 0..<totalRows {
      if sender.isSelected{
        self.tableView.selectRow(at: IndexPath(row: row, section: 1), animated: true, scrollPosition: UITableView.ScrollPosition.none)
        let spot = User.current?.currentClub?.sortedSpotsBranchName[row]
        self.spots.insert((spot?.id)!)
      }else{
        self.tableView.deselectRow(at: IndexPath(row: row, section: 1), animated: true)
        let spot = User.current?.currentClub?.sortedSpotsBranchName[row]
        self.spots.remove((spot?.id)!)
      }
      
      
    }
  }
  
  
  func validateData() -> Void {
    if User.current != nil && User.current?.permission != nil {
      if User.current?.permission == "owner" || User.current?.permission == "all_spots" {
        NSLog("spots === > %d", self.spots.count)
        if self.spots.count > 0 {
          self.customNextButton?.isEnabled = true
          self.makeParams()
        }else{
          self.customNextButton?.isEnabled = false
        }
      }else if User.current?.permission == "some_spots" {
        NSLog("spots === > %d", self.spots.count)
        if self.spots.count > 0 {
          self.customNextButton?.isEnabled = true
          self.makeParams()
        }else{
          self.customNextButton?.isEnabled = false
        }
      }
    }
    
  }
  
  private func makeParams() -> Void{
    self.params = [String : Any]()
    self.params["club_id"] = User.current?.currentClub?.id
    
    if User.current?.permission == "some_spots"{
      self.params["permission"] = "some_spots"
      var array = [Int]()
      for spot in self.spots{
        array.append(spot)
      }
      self.params["spots"] = array
    }else{ //all_spots or owner
      if User.current?.currentClub?.accesibleSpots.count == self.spots.count {
        self.params["spots"] = [Int]()
        self.params["permission"] = "all_spots"
      }else{
        self.params["permission"] = "some_spots"
        var array = [Int]()
        for spot in self.spots{
          array.append(spot)
        }
        self.params["spots"] = array
      }
    }
    NSLog("params ====> %@", self.params)
    
  }
  
  
  private func showActivityIndicator() -> Void {
    self.activityIndicator!.startAnimating()
    self.activityIndicator!.isHidden = false
  }
  
  private func hideActivityIndicator() -> Void {
    self.activityIndicator!.stopAnimating()
    self.activityIndicator!.isHidden = true
  }
  
  
}
