//
//  MockCacheManager.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

@testable import Weather

final class MockCacheManager: CacheManagerProtocol {
  private var store: [String: Any] = [:]
  private(set) var setCallCount = 0
  private(set) var getCallCount = 0
  private(set) var lastSetKey: String?
  private(set) var lastSetExpiresIn: TimeInterval?

  func set<T>(_ key: String, value: T, expiresIn: TimeInterval?) {
    setCallCount += 1
    lastSetKey = key
    lastSetExpiresIn = expiresIn
    store[key] = value
  }

  func get<T>(_ key: String) -> T? {
    getCallCount += 1
    return store[key] as? T
  }
}
