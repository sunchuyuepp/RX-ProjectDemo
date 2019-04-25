//
//  RequestParamters.swift
//  RX_Product
//
//  Created by sunny on 2019/4/19.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import Foundation
import Moya



class RequestParamters {
  static func build(_ api:RequestAPI)->Task {
    switch api {
    case .repositories(let query):
      var params: [String: Any] = [:]
      params["q"] = query
      params["sort"] = "stars"
      params["order"] = "desc"
      return Task.requestParameters(parameters: params, encoding: URLEncoding.default)
    default:
      return Task.requestPlain
    }
  }
}
