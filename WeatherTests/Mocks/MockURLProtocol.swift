//
//  MockURLProtocol.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

/// A URLProtocol subclass that intercepts all requests and returns a
/// configurable stub response, allowing `WeatherApiClient` to be tested
/// without hitting the network.
final class MockURLProtocol: URLProtocol {

  // MARK: - Stub configuration (set before each test)

  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

  // MARK: - URLProtocol

  override class func canInit(with request: URLRequest) -> Bool { true }
  override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

  override func startLoading() {
    guard let handler = MockURLProtocol.requestHandler else {
      client?.urlProtocolDidFinishLoading(self)
      return
    }
    do {
      let (response, data) = try handler(request)
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      if let data = data {
        client?.urlProtocol(self, didLoad: data)
      }
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }

  override func stopLoading() {}
}
