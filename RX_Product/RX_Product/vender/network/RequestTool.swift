import Foundation
import RxSwift
import Moya
import ObjectMapper
import RxCocoa
import Alamofire

public extension Reactive where Base: MoyaProviderType {
  
  public func requestWithRoter(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
    return Single.create { [weak base] single in
      let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
        switch result {
        case let .success(response):
          single(.success(response))
        case let .failure(error):
          single(.error(error))
        }
      }
      return Disposables.create {
        cancellableToken?.cancel()
      }
    }
  }
}


struct RequestTool {
  private static let provider = MoyaProvider<RequestAPI>(manager: RXAFManager.manager,
                                                plugins: [NetworkLoadingPlugin(),
                                                         NetworkTimeoutPlugin(), NetworkLoggerPlugin(verbose: true)])
  static func request <T: BaseMappable>(_ token:RequestAPI, _ type: T.Type, context: MapContext? = nil)->SharedSequence<DriverSharingStrategy, T> {
    let sequence = provider.rx.requestWithRoter(token)
    .filterSuccessfulStatusCodes()
      .flatMap { response -> Single<T> in
        return Single.just(try response.mapObject(type, context: context))
      }.asDriver(onErrorDriveWith: Driver.empty())
    return sequence
  }
}

// MARK: - Easycash AF Manager
final class RXAFManager: SessionManager {
  static let serverTrustPolicies: [String: ServerTrustPolicy] = {
    //    switch ECApp.buildType {
    //    case .appStore, .prod:
    //      return [
    //        "api.geteasycash.asia": .pinCertificates(
    //          certificates: ServerTrustPolicy.certificates(),
    //          validateCertificateChain: true,
    //          validateHost: true
    //        ),
    //        "apifeat.geteasycash.asia": .pinCertificates(
    //          certificates: ServerTrustPolicy.certificates(),
    //          validateCertificateChain: true,
    //          validateHost: true
    //        ),
    //        "www.geteasycash.asia": .pinCertificates(
    //          certificates: ServerTrustPolicy.certificates(),
    //          validateCertificateChain: true,
    //          validateHost: true
    //        ),
    //        "feat.geteasycash.asia": .pinCertificates(
    //          certificates: ServerTrustPolicy.certificates(),
    //          validateCertificateChain: true,
    //          validateHost: true
    //        )
    //      ]
    //    default:
    return [:]
    //    }
  }()
  
  static let manager = SessionManager(
    serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
  )
}
