//
//  MockLocationsPersistedStore.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

@testable import Weather

final class MockLocationsPersistedStore: LocationsPersistedStoreProtocol {
  var locations: [Location] = []

  func appendLocation(location: Location) {
    locations.removeAll { $0 == location }
    locations.insert(location, at: 0)
  }

  func readLocations() -> [Location] {
    return locations
  }

  // PersistedStoreProtocol
  func set<T>(_ key: String, value: T) {}
  func get<T>(_ key: String) -> T? { nil }
}
