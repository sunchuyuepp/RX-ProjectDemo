//
//  PersonalProfileModel.swift
//  RX_Product
//
//  Created by sunny on 2019/4/24.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import Differentiator
import RxSwift
import RxDataSources

enum ProfileSectionType {
  case personalInfo
  case bankAccount
  case transactionHistory
  case helpCenter
  case aboutUs
  case accountSecurity
  case invitationCode
  case hotLine
  case logOut
}

struct PersonalProfileModel {
  var sectionName:String
  var sectionType:ProfileSectionType
  
  init(_ name:String, _ type:ProfileSectionType) {
    self.sectionName = name
    self.sectionType = type
  }
}

struct PersonSection {
  var name:String
  var items:[PersonalProfileModel]
}

extension PersonSection: SectionModelType {
  typealias Item = PersonalProfileModel
  init(original: PersonSection, items: [Item]) {
    self = original
    self.items = items
  }
}
