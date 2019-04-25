//
//  RequestAPI.swift
//  RX_Product
//
//  Created by sunny on 2019/4/1.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import Foundation
import Moya



public enum RequestAPI {
  case repositories(String)
  case response
}

//let provider = MoyaProvider<RequestAPI>()

extension RequestAPI: TargetType {
  public var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  public var path: String {
    return requestPath()
  }
  
  public var method: Moya.Method {
    switch self {
    case .repositories:
      return .get
    default:
      return .post
    }
  }
  
  public var sampleData: Data {
    return "{}".data(using: String.Encoding.utf8)!
  }
  
  public var task: Task {
    return RequestParamters.build(self)
  }
  
  public var headers: [String : String]? {
    let header = ["platformType": "IOS",
                   "build": "RX-Build"]
    return header
  }
}

extension RequestAPI: NetworkLoadingProtocol, NetworkTimeoutProtocol {
  var loadingOption: LoadingOption {
    return .showNothing
  }
  var timeout: TimeInterval {
    return 10.0
  }
}

