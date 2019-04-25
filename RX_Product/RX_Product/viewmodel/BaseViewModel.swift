//
//  BaseViewModel.swift
//  RX_Product
//
//  Created by sunny on 2019/4/1.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya_ObjectMapper

class BaseViewModel {
  
  fileprivate let searchAction:Driver<String>
  
  init(searchAction:Driver<String>) {
    self.searchAction = searchAction
    
  }
}

