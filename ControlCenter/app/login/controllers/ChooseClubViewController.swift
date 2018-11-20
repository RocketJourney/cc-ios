//
//  ChooseClubViewController.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class ChooseClubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  func setupView() -> Void {
    self.title = "CHOOSE_CLUB".localized
    
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell") as! ClubTableViewCell
    
    return cell
  }

}
