//
//  SendLinkViewController.swift
//  ControlCenter
//
//  Created by Erik on 12/12/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import SVProgressHUD

class SendLinkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  
  @IBOutlet weak var tableView: UITableView!
  var items = [String]()
  var linkShare: String?
  var customDoneButton: UIButton?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  
  func setupView() -> Void {
    self.backBtn()
    self.view.backgroundColor = UIColor(hex: 0x212121)
    let item1 = "SEND_LINK_COLLEAGUES".localized
    let item2 = "COPY_LINK".localized
    self.items = [item1, item2]
    self.title = "SEND_LINK".localized
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width - 40, height: 20))
    label.text = "LINK_EXPIRE".localized
    label.font = UIFont.montserratRegular(14)
    label.textColor = UIColor(hex: 0x8a8a8a)
    label.numberOfLines = 0
    label.sizeToFit()
    
    let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 80))
    contentView.addSubview(label)
    
    label.snp.makeConstraints { (make) in
      make.top.equalTo(contentView.snp.top).offset(0)
      make.trailing.equalTo(contentView.snp.trailing).offset(-20)
      make.leading.equalTo(contentView.snp.leading).offset(20)
      make.bottom.equalTo(contentView.snp.bottom).offset(-10)
    }
    self.tableView.separatorColor = UIColor(hex: 0x212121)
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = contentView
    self.tableView.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "kLinkCell")
    
    self.customDoneButton = UIButton()
    self.customDoneButton?.titleLabel?.font = UIFont.montserratBold(18)
    self.customDoneButton?.setTitle("Done".localized, for: .normal)
    self.customDoneButton?.setTitleColor(UIColor.rocketYellow(), for: .normal)
    self.customDoneButton?.setTitleColor(UIColor.rocketGrayChat(), for: .highlighted)
    self.customDoneButton?.setTitleColor(UIColor.rocketGrayChat(), for: .selected)
    
    self.customDoneButton!.addTarget(self, action: #selector(self.dismissViewController), for: .touchUpInside)
    let nextButton = UIBarButtonItem(customView: self.customDoneButton!)
    self.navigationItem.rightBarButtonItem = nextButton
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kLinkCell") as! LinkCell
    switch indexPath.row {
    case 0:
      cell.imageView?.image = UIImage(named: "send-link-icon")
    default:
      cell.imageView?.image = UIImage(named: "copy-link-icon")
    }
    cell.textLabel?.text = self.items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.row {
    case 0:
      let someText:String = ""
      let objectsToShare:URL = URL(string: self.linkShare!)!
      let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
      let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
      activityViewController.popoverPresentationController?.sourceView = self.view
      
      activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,
                                                       UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
      
      self.present(activityViewController, animated: true, completion: nil)
      activityViewController.completionWithItemsHandler = {
        (activity, success, items, error) in
        //print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
        if success {
          
        }
      }
    default:
      if self.linkShare != nil {
        SVProgressHUD.showSuccess(withStatus: "LINK_COPIED".localized)
        UIPasteboard.general.string = self.linkShare
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
  }
  
  @objc func dismissViewController() -> Void {
    self.dismissView()
  }
  
}
