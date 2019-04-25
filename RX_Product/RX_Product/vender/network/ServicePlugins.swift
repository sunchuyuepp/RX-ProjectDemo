//
//  ServicePlugins.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//
import Moya
import Result
import SVProgressHUD

enum LMErrorOption {
  case showNothing
  case `default`
}

enum LoadingOption {
  case showNothing
  /// allow userinteraction
  case loading
  /// stop userinteraction
  case maskLoading
  /// 有灰色透明底的loading
  case loadingWithLightStyle
}

protocol NetworkLoadingProtocol {
  var loadingOption: LoadingOption { get }
}


protocol NetworkTimeoutProtocol {
  var timeout: TimeInterval { get }
}

final class NetworkLoadingPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    if let ecTarget = target as? NetworkLoadingProtocol {
      switch ecTarget.loadingOption {
      case .loading:
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.show()
      case .maskLoading:
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
      default:
        break
      }
    }
    return request
  }
  
  func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    if let ecTarget = target as? NetworkLoadingProtocol {
      switch ecTarget.loadingOption {
      case .showNothing:
        break
      default:
        SVProgressHUD.dismiss()
      }
    }
  }
}


final class NetworkTimeoutPlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var mRequest = request
    if let ecTarget = target as? NetworkTimeoutProtocol {
      mRequest.timeoutInterval = ecTarget.timeout
      return mRequest
    } else {
      return request
    }
  }
}
