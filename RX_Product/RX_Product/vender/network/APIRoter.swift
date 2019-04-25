//
//  APIRoter.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit

extension RequestAPI {
  func requestPath() -> String {
    switch self {
    case .repositories(_):
      return "/search/repositories"
    default:
      return "aaa"
    }
  }
}
