//
//  CacheManager.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

final class CacheManager: CacheManagerProtocol {
  private var cache: [String: CacheItem] = [:]

  func set<T>(_ key: String, value: T, expiresIn: TimeInterval? = nil) {
    self.cache[key] = CacheItem(value: value, expiresIn: expiresIn)
  }

  func get<T>(_ key: String) -> T? {
    guard let item = self.cache[key] else { return nil }

    if item.isExpired {
      self.cache.removeValue(forKey: key)
      return nil
    }

    return item.value as? T
  }
}

private struct CacheItem {
  let value: Any
  let expirationDate: Date?

  init(value: Any, expiresIn: TimeInterval? = nil) {
    self.value = value
    self.expirationDate = expiresIn.map { Date().addingTimeInterval($0) }
  }

  var isExpired: Bool {
    guard let expirationDate else { return false }
    return Date() > expirationDate
  }
}
