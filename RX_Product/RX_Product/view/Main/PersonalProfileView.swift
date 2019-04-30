//
//  PersonalProfileView.swift
//  RX_Product
//
//  Created by sunny on 2019/4/24.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import RxCocoa

class PersonalProfileView: UIView {

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame:self.bounds, style:.plain)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: "ProfileHeaderCell")
    tableView.estimatedRowHeight = 60
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
//    tableView.mj_header = MJRefreshNormalHeader()
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(tableView)
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
