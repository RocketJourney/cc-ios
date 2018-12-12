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
    
    self.customNextButton!.addTarget(self, action: #selector(self.createInvitation), for: .touchUpInside)
    self.customNextButton!.addSubview(self.activityIndicator!)
    
    self.nextButton = UIBarButtonItem(customView: customNextButton!)
    self.navigationItem.rightBarButtonItem = self.nextButton
  
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.activityIndicator?.center = CGPoint(x: ((self.customNextButton?.frame.width)! - ((self.activityIndicator?.frame.width)!) / 2), y: (self.customNextButton?.center.y)!)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
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
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kInviteCell") as! InviteCell
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
  @objc private func createInvitation() -> Void {
    NSLog("create invite")
    self.activityIndicator?.startAnimating()
    let sendLinkController = SendLinkViewController(nibName: "SendLinkViewController", bundle: nil)
    sendLinkController.linkShare = "https://rocketjourney.com"
    self.navigationController?.pushViewController(sendLinkController, animated: true)    
  }
  
  
}
