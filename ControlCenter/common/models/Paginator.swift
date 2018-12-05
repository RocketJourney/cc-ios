//
//  Paginator.swift
//  ControlCenter
//
//  Created by Erik on 11/30/18.
//  Copyright © 2018 RocketJourney. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class Paginator: Object {
  
  @objc dynamic var totalPages = 0
  @objc dynamic var totalEntries = 0
  @objc dynamic var pageSize = 0
  @objc dynamic var pageNumber = 0
  
  
  class func fromJSON(_ json: JSON) -> Paginator {
    let paginator = Paginator()
    
    if let totalEntries = json["total_entries"].int {
      paginator.totalEntries = totalEntries
    }
    
    if let totalPages = json["total_pages"].int {
      paginator.totalPages = totalPages
    }
    
    if let pageSize = json["page_size"].int {
      paginator.pageSize = pageSize
    }
    
    if let pageNumber = json["page_number"].int {
      paginator.pageNumber = pageNumber
    }
    
    return paginator
  }
  
  
}
