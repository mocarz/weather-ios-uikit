//
//  PersistedStore.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

class PersistedStore: PersistedStoreProtocol {
  private let userDefaults: UserDefaults
  private let jsonEncoder = JSONEncoder()
  private let jsonDecoder = JSONDecoder()
  private let keyPrefix: String

  init(userDefaults: UserDefaults = .standard, keyPrefix: String = "PersistedStore") {
    self.userDefaults = userDefaults
    self.keyPrefix = keyPrefix
  }

  deinit {}

  private func namespacedKey(_ key: String) -> String {
    return "\(keyPrefix).\(key)"
  }

  func set<T>(_ key: String, value: T) {
    let nsKey = namespacedKey(key)
    self.userDefaults.set(value, forKey: nsKey)
  }

  func get<T>(_ key: String) -> T? {
    let nsKey = namespacedKey(key)
    return self.userDefaults.object(forKey: nsKey) as? T
  }
}
