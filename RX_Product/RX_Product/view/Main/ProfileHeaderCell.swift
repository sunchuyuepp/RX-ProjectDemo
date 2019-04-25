//
//  ProfileHeaderCell.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderCell: UITableViewCell {

  
  // MARK: - Properties
  static let ECProfileHeaderCellCellIdentifier = "ECProfileHeaderCellCellIdentifier"
  static let ECProfileHeaderCellCellHeight: CGFloat = 140.0
  
//  var profileModel: ECUserProfileModel? {
//    didSet {
//      self.totalNumberLabel.text = profileModel?.asset.formatterNumberValue(prefix: false, keepTwoDecimals: true)
//      self.leftNumberLabel.text = profileModel?.earnings.formatterNumberValue(prefix: true, keepTwoDecimals: true)
//      self.rightNumberLabel.text = profileModel?.totalEarnings.formatterNumberValue(prefix: true, keepTwoDecimals: true)
//    }
//  }
  
  var tttt:String? {
    didSet {
      self.totalNumberLabel.text = "10000"
            self.leftNumberLabel.text = "100000"
            self.rightNumberLabel.text = "10000"
    }
  }
  // MARK: - Init Method
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = UIColor.clear
    self.backgroundColor = UIColor.clear
    self.selectionStyle = UITableViewCell.SelectionStyle.none
   
    let blueView = UIView()
    blueView.backgroundColor = UIColor.init(red: 63/255, green: 68/255, blue: 234/255, alpha: 1)
    self.contentView.addSubview(blueView)
    
    blueView.snp.makeConstraints { (make) in
      make.left.top.right.bottom.equalToSuperview()
    }
    blueView.addSubview(totalTitleLabel)
    blueView.addSubview(totalNumberLabel)
    totalNumberLabel.snp.makeConstraints { (make) in
      make.left.right.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(10)
    }
    totalTitleLabel.snp.makeConstraints { (make) in
      make.left.right.equalTo(totalNumberLabel)
      make.top.equalTo(totalNumberLabel.snp.bottom).offset(15)
    }
    
    blueView.addSubview(leftNumberLabel)
    blueView.addSubview(leftTagLabel)
    blueView.addSubview(rightNumberLabel)
    blueView.addSubview(rightTagLabel)
    leftNumberLabel.snp.makeConstraints { (make) in
      make.left.equalTo(totalNumberLabel.snp.left)
      make.right.equalTo(blueView.snp.centerX)
      make.top.equalTo(totalTitleLabel.snp.bottom).offset(20)
    }
    leftTagLabel.snp.makeConstraints { (make) in
      make.left.right.equalTo(leftNumberLabel)
      make.top.equalTo(leftNumberLabel.snp.bottom).offset(6)
      make.bottom.equalToSuperview().inset(20)
    }
    rightNumberLabel.snp.makeConstraints { (make) in
      make.left.equalTo(blueView.snp.centerX).offset(15)
      make.right.equalToSuperview().inset(20)
      make.centerY.equalTo(leftNumberLabel.snp.centerY)
    }
    rightTagLabel.snp.makeConstraints { (make) in
      make.left.right.equalTo(rightNumberLabel)
      make.centerY.equalTo(leftTagLabel)
      
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lazy Properties
  private lazy var totalNumberLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.white
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    return label
  }()
  
  private lazy var totalTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.white
    label.font = UIFont(name: "HelveticaNeue", size: 12)
    label.text = "Total Assets (Rp,include the reward)"
    return label
  }()
  
  private lazy var leftNumberLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    label.textColor = UIColor.white
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  private lazy var rightNumberLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    label.textColor = UIColor.white
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  private lazy var leftTagLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue", size: 12)
    label.textColor = UIColor.white
    label.text = "Yesterday Return"
    return label
  }()
  
  private lazy var rightTagLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue", size: 12)
    label.textColor = UIColor.white
    label.text = "Total Return"
    return label
  }()
}
