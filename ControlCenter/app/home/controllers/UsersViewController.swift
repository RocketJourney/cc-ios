//
//  UsersViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/26/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import CCInfiniteScrolling

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  var spot: Spot?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.printData()
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.printData), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  
  private func setupView() -> Void {
    self.view.backgroundColor = UIColor(hex: 0x212121)
    
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.separatorColor = UIColor(hex: 0x212121)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "kUserCell")
    self.tableView.tableFooterView = UIView()
    
    self.tableView.infiniteScrollingDisabled = false
    let spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
    spinnerView.backgroundColor = UIColor.clear
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    spinnerView.addSubview(spinner)
    spinner.center = spinnerView.center
    spinner.startAnimating()
    self.tableView.bottomInfiniteScrollingCustomView = spinnerView
    self.tableView.addBottomInfiniteScrolling {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        self.reachToBottom()
      })
      
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if User.current != nil && User.current?.selectedSpot != nil {
      return User.current?.selectedSpot?.assistants.count ?? 0
    }else {
      let club = User.current?.currentClub
      return club?.assistants.count ?? 0
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kUserCell") as! UserCell
    
    if User.current != nil && User.current?.selectedSpot != nil {
      let assistant = User.current?.selectedSpot?.assistants[indexPath.row]
      cell.bind(assistant: assistant!)
    }else {
      let assistant = User.current?.currentClub?.assistants[indexPath.row]
      cell.bind(assistant: assistant!)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
  private func getClubAssistants() -> Void {
    if self.isNetworkReachable(){
      self.tableView.isHidden = true
      self.showActivityIndicator()
      User.current?.getClubAssistans(clubId: (User.current?.currentClub?.id)!, completion: {
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
    } else {
      self.noInternetAlert()
    }
  }
  
  
  private func getSpotAssistants() -> Void {
    if self.isNetworkReachable(){
      self.tableView.isHidden = true
      self.showActivityIndicator()
      let spotModel = User.current?.selectedSpot
      User.current?.getSpotAssistans(clubId: (spotModel?.clubId)!, spotId: (spotModel?.id)!, completion: {
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
    } else {
      self.noInternetAlert()
    }
  }
  
  
  private func getClubAssistantsPaginate() -> Void {
    if self.isNetworkReachable(){
      
      let clubModel = User.current?.currentClub
      NSLog("paginator ====> %@", (clubModel?.paginator)!)
      User.current?.getClubAssistansPaginate(clubId: (clubModel?.id)!, page: (clubModel?.paginator?.pageNumber)! + 1, completion: {
        self.printDataPaginate()
      }, error: { (error) in
        if let error = error as? NSError {
          if error.code == 500 {
            self.internalServerError()
          }
        }
      })
    } else {
      self.noInternetAlert()
    }
  }
  
  
  private func getSpotAssistantsPaginate() -> Void {
    if self.isNetworkReachable(){
      let spotModel = User.current?.selectedSpot
      NSLog("paginator ====> %@", (spotModel?.paginator)!)
      User.current?.getSpotAssistansPaginate(clubId: (spotModel?.clubId)!, spotId: (spotModel?.id)!, page: (spotModel?.paginator?.pageNumber)! + 1, completion: {
        self.printDataPaginate()
      }, error: { (error) in
        if let error = error as? NSError {
          if error.code == 500 {
            self.internalServerError()
          }
        }
      })
    } else {
      self.noInternetAlert()
    }
  }
  
  
  @objc func getDataFromServer() -> Void {
    UIApplication.shared.applicationIconBadgeNumber = 0
    if User.current != nil && User.current?.selectedSpot != nil {
      self.getSpotAssistants()
    }else{
      self.getClubAssistants()
    }
    
  }
  
  
  private func getDataFromServerPaginate() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      self.getSpotAssistantsPaginate()
    }else{
      self.getClubAssistantsPaginate()
    }
    
  }
  
  
  
  @objc private func printData() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      self.printSpotData()
    }else {
      self.printClubData()
    }
  }
  
  
  private func printDataPaginate() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      self.printSpotDataPaginate()
    }else {
      self.printClubDataPaginate()
    }
  }
  
  
  
  private func printClubData() -> Void {
    self.tableView.reloadData()
    self.tableView.infiniteScrollingDisabled = false
    self.scrollToTop()
  }
  
  private func printSpotData() -> Void {
    self.tableView.reloadData()
    self.tableView.infiniteScrollingDisabled = false
    self.scrollToTop()
  }
  
  
  private func printClubDataPaginate() -> Void {
    let paginator = User.current?.currentClub?.paginator
    if paginator != nil &&  (paginator?.totalPages)! >= (paginator?.pageNumber)!  {
      let index = ((User.current?.currentClub?.assistants.count)! - (User.current?.currentClub?.paginator?.pageSize)!)
      self.tableView.reloadData()
      if index > 0 {
        UIView.performWithoutAnimation {
          self.tableView.scrollToRow(
            at: IndexPath(row: index, section: 0),
            at: .bottom,
            animated: false
          )
        }
      }
      
    }else{
      self.tableView.infiniteScrollingDisabled = true
    }
    
    
    
  }
  
  private func printSpotDataPaginate() -> Void {
    let paginator = User.current?.selectedSpot?.paginator
    if paginator != nil &&  (paginator?.totalPages)! >= (paginator?.pageNumber)!  {
      let index = ((User.current?.selectedSpot?.assistants.count)! - (User.current?.selectedSpot?.paginator?.pageSize)!)
      
      self.tableView.reloadData()
      if index > 0 {
        UIView.performWithoutAnimation {
          self.tableView.scrollToRow(
            at: IndexPath(row: index, section: 0),
            at: .bottom,
            animated: false
          )
        }
      }
      
    }else {
      self.tableView.infiniteScrollingDisabled = true
    }
  }
  
  
  
  private func reachToBottom() -> Void {
    self.getDataFromServerPaginate()
  }
  
  func setupReachBottom() -> Void {
    self.tableView.infiniteScrollingDisabled = false
  }
  
  private func showActivityIndicator() -> Void {
    self.activityIndicator.startAnimating()
    self.activityIndicator.isHidden = false
  }
  
  private func hideActivityIndicator() -> Void {
    self.activityIndicator.stopAnimating()
    self.activityIndicator.isHidden = true
  }
  
  private func scrollToTop() -> Void {
    if User.current != nil && User.current?.selectedSpot != nil {
      if (User.current?.selectedSpot?.assistants.count)! > 0 {
        UIView.performWithoutAnimation {
          self.tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: false
          )
        }
      }
    }else {
      let club = User.current?.currentClub
      if (club?.assistants.count)! > 0 {
        UIView.performWithoutAnimation {
          self.tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: false
          )
        }
      }
      
    }
  }
}
