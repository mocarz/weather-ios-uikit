//
//  MockUserDefaults.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 13/04/2026.
//

import Foundation

final class MockUserDefaults: UserDefaults {
  private var storage: [String: Any] = [:]

  override func set(_ value: Any?, forKey key: String) {
    if let value {
      storage[key] = value
    } else {
      storage.removeValue(forKey: key)
    }
  }

  override func object(forKey key: String) -> Any? {
    storage[key]
  }

  override func removeObject(forKey key: String) {
    storage.removeValue(forKey: key)
  }
}
