//
//  StatusCell.swift
//  ControlCenter
//
//  Created by Erik on 11/29/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var counterStatusLabel: UILabel!
  @IBOutlet weak var textStatusLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupView()
  }
  
  func setupView() -> Void {
    self.backgroundColor = UIColor(hex: 0x2d2d2d)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
