//
//  ChooseClubViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseClubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    // Do any additional setup after loading the view.
  }
  
  func setupView() -> Void {
    self.title = "CHOOSE_CLUB".localized
    self.view.backgroundColor = UIColor(hex: 0x212121)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorColor = UIColor(hex: 0x313131)
    self.tableView.register(UINib(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "clubCell")
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (User.current?.sortedClubs.count)!
    
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = UIColor.clear
    return view
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell") as! ClubTableViewCell
    let club = User.current?.sortedClubs[indexPath.row]
    cell.bind(club: club!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let club = User.current?.sortedClubs[indexPath.row]
    self.saveData(club: club!)
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  
  private func saveData(club: Club) -> Void {
    let realm = try! Realm(configuration: ControlCenterRealm.config)
    try! realm.write {
      User.current?.currentClub = club
    }
    
    self.dismissView()
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
    NotificationCenter.default.post(name: NSNotification.Name("dismissChooseClublNotification"), object: nil)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
      NotificationCenter.default.post(name: NSNotification.Name("showIntroViewController"), object: nil)
    }
  }
  
}
