//
//  ViewModel.swift
//  RX_Product
//
//  Created by sunny on 2019/4/1.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya_ObjectMapper

class ViewModel:BaseViewModel {
  
  var username:String?
  var searchResult:Driver<Repositories>
  var repositories:Driver<[Repository]>
  var cleanResult:Driver<Void>
  var navigationTitle:Driver<String>
  
  override init(searchAction: Driver<String>) {
    self.searchResult = searchAction
      .filter{ !$0.isEmpty }
      .flatMapLatest{
        RequestTool.request(.repositories($0), Repositories.self)
    }
    //生成清空结果动作序列
    self.cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
    self.repositories = Driver.merge(
      searchResult.map{ $0.itemss },
      cleanResult.map{[]}
    )
    //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
    self.navigationTitle = Driver.merge(
      searchResult.map{ "共有 \($0.totalCounts!) 个结果" },
      cleanResult.map{ "hangge.com" }
    )
    super.init(searchAction: searchAction)
  }
  
}

