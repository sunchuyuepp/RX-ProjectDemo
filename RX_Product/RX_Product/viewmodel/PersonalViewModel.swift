//
//  PersonalViewModel.swift
//  RX_Product
//
//  Created by sunny on 2019/4/24.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PersonalViewModel: NSObject {
  var endBlock:(()->())?
  var headerRefreshing:Driver<Bool>?
  var footerRefreshing:Driver<Bool>?
  var sections:Driver<[PersonSection]>?
  let bag = DisposeBag()
  var datas:BehaviorRelay<[PersonSection]>?
  
  var flag = 0
  var sectionSource:RxTableViewSectionedReloadDataSource<PersonSection> {
    return RxTableViewSectionedReloadDataSource<PersonSection>(configureCell:{ ds, tableView, indexpath, item in
      
      switch item.sectionType {
      case .personalInfo:
        let cell = ProfileHeaderCell(style: .subtitle, reuseIdentifier: "ProfileHeaderCell")
        cell.tttt = "aaaa"
        
        return cell
      default:
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = item.sectionName
        return cell
      }
    }, titleForHeaderInSection: { (dataSource, index) -> String? in
      if index == 0 {
        return nil
      }
      
      return " "
    })
  }
  
  init(driver:Driver<Void>, hf:Driver<Void>, ff:Driver<Void>) {
    super.init()
    self.datas = BehaviorRelay<[PersonSection]>(value: [])
    
    let btnDriver = driver
      .startWith(())
      .flatMapLatest(getResult)
    
    btnDriver.drive(onNext: { (items) in
      self.datas?.accept(items)
    }).disposed(by: bag)
    
    let headerRefreshData = hf.flatMapLatest(getResult)
    let endRefreshData = ff.flatMapLatest(getResult)
    
    _ = headerRefreshData.drive(onNext: { (items) in
      self.datas?.accept(items)
      if let b = self.endBlock {
        b()
      }
    })
    
    _ = endRefreshData.drive(onNext: { (items) in
      self.datas?.accept(items)
      if let b = self.endBlock {
        b()
      }
    })
    self.headerRefreshing = headerRefreshData.map{ _ in true }
    self.footerRefreshing = endRefreshData.map{ _ in true }
  }
  
  func getResult() -> Driver<[PersonSection]> {
    flag += 1
    if flag%2 == 0 {
      return Driver.of([
        PersonSection(name: "info", items: [PersonalProfileModel("info", .personalInfo)]),
        PersonSection(name: "other", items: [PersonalProfileModel("Bank Account", ProfileSectionType.bankAccount),
                                             PersonalProfileModel("Transaction History", ProfileSectionType.transactionHistory),
                                             PersonalProfileModel("Help Center", ProfileSectionType.helpCenter),
                                             PersonalProfileModel("About Us", ProfileSectionType.aboutUs),
                                             PersonalProfileModel("Account Security", ProfileSectionType.accountSecurity),
                                             PersonalProfileModel("Invitation Code", ProfileSectionType.invitationCode),
                                             PersonalProfileModel("Hotline", ProfileSectionType.hotLine),
                                             PersonalProfileModel("Log Out", ProfileSectionType.logOut)])
        
        ])
    }
    return Driver.of([
      PersonSection(name: "info", items: [PersonalProfileModel("info", .personalInfo)]),
      PersonSection(name: "other", items: [PersonalProfileModel("Bank Account", ProfileSectionType.bankAccount),
                                           PersonalProfileModel("Transaction History", ProfileSectionType.transactionHistory),
                                           PersonalProfileModel("Help Center", ProfileSectionType.helpCenter),
                                           PersonalProfileModel("About Us", ProfileSectionType.aboutUs),
                                           PersonalProfileModel("Account Security", ProfileSectionType.accountSecurity)])
      
      ])
    
  }
}
