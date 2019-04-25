//
//  PersonalProfileViewController.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import RxDataSources
import RxCocoa
import RxSwift

class PersonalProfileViewController: BaseViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let rootView = PersonalProfileView(frame: self.view.bounds)
    self.view = rootView
    let b = addRightBarItem("刷新", nil)
    
    let btnDriver = b.rx.tap.asDriver()
    
    rootView.tableView.mj_header = MJRefreshNormalHeader()
    rootView.tableView.mj_footer = MJRefreshAutoNormalFooter()
//      MJRefreshFooter()
    
    
    
    let vm = PersonalViewModel(driver: btnDriver, hf: rootView.tableView.mj_header.rx.refreshing.asDriver(), ff: rootView.tableView.mj_footer.rx.refreshing.asDriver())
    _ = rootView.tableView.rx.modelSelected(PersonalProfileModel.self).subscribe(onNext: { (model) in
      print("aaaa")
      
    }).disposed(by: disposeBag)
    vm.endBlock = {
      sleep(3)
      rootView.tableView.mj_header.endRefreshing()
      rootView.tableView.mj_footer.endRefreshing()
    }
    
    vm.datas?
      .asDriver(onErrorJustReturn: [])
      .drive(rootView.tableView.rx.items(dataSource: vm.sectionSource))
      .disposed(by: disposeBag)
  }
  
  
}
