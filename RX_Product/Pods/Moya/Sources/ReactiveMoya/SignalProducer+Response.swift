import Foundation
import ReactiveSwift
#if !COCOAPODS
import Moya
#endif

// just to try if this fixes the build
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit.UIImage
#elseif os(macOS)
import AppKit.NSImage
#endif

/// Extension for processing raw NSData generated by network access.
extension SignalProducerProtocol where Value == Response, Error == MoyaError {

    /// Filters out responses that don't fall within the given range, generating errors when others are encountered.
    public func filter<R: RangeExpression>(statusCodes: R) -> SignalProducer<Value, MoyaError> where R.Bound == Int {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.filter(statusCodes: statusCodes) }
        }
    }

    /// Filters out responses that have the specified `statusCode`.
    public func filter(statusCode: Int) -> SignalProducer<Value, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.filter(statusCode: statusCode) }
        }
    }

    /// Filters out responses where `statusCode` falls within the range 200 - 299.
    public func filterSuccessfulStatusCodes() -> SignalProducer<Value, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.filterSuccessfulStatusCodes() }
        }
    }

    /// Filters out responses where `statusCode` falls within the range 200 - 399
    public func filterSuccessfulStatusAndRedirectCodes() -> SignalProducer<Value, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.filterSuccessfulStatusAndRedirectCodes() }
        }
    }

    /// Maps data received from the signal into an Image. If the conversion fails, the signal errors.
    public func mapImage() -> SignalProducer<Image, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.mapImage() }
        }
    }

    /// Maps data received from the signal into a JSON object. If the conversion fails, the signal errors.
    public func mapJSON(failsOnEmptyData: Bool = true) -> SignalProducer<Any, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.mapJSON(failsOnEmptyData: failsOnEmptyData) }
        }
    }

    /// Maps received data at key path into a String. If the conversion fails, the signal errors.
    public func mapString(atKeyPath keyPath: String? = nil) -> SignalProducer<String, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.mapString(atKeyPath: keyPath) }
        }
    }

    /// Maps received data at key path into a Decodable object. If the conversion fails, the signal errors.
    public func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> SignalProducer<D, MoyaError> {
        return producer.flatMap(.latest) { response in
            unwrapThrowable { try response.map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData) }
        }
    }
}

/// Maps throwable to SignalProducer.
private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, MoyaError> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        if let error = error as? MoyaError {
            return SignalProducer(error: error)
        } else {
            // The cast above should never fail, but just in case.
            return SignalProducer(error: MoyaError.underlying(error as NSError, nil))
        }
    }
}
