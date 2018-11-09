//
//  ClubTableViewCell.swift
//  ControlCenter
//
//  Created by Erik on 11/9/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {
  
  @IBOutlet weak var clubImageView: UIImageView!
  @IBOutlet weak var titleClubLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor(hex: 0x333333)
    self.clubImageView.layer.cornerRadius = AppDelegate.ratioImages * self.clubImageView.frame.height
    self.clubImageView.layer.masksToBounds = true
    
    self.titleClubLabel.textColor = UIColor.white
    self.titleClubLabel.font = UIFont.montserratRegular(18)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
