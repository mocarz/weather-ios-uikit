//
//  LocationsPersistedStore.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

final class LocationsPersistedStore: PersistedStore, LocationsPersistedStoreProtocol {
  private let locationsKey = "locations"

  init(userDefaults: UserDefaults = .standard, initialLocations: [Location] = []) {
    super.init(userDefaults: userDefaults, keyPrefix: "LocationsPersistedStore")
    let storedLocations: [Location]? = self.get(self.locationsKey)
    guard storedLocations == nil else { return }
    self.set(self.locationsKey, value: initialLocations)
  }

  func appendLocation(location: Location) {
    var locations = readLocations()

    // remove existing location if already exists to avoid duplicates and keep recently accessed locations at the beginning of the list
    locations.removeAll { $0 == location }

    locations.insert(location, at: 0)
    self.set(self.locationsKey, value: locations)
  }

  func readLocations() -> [Location] {
    return self.get(self.locationsKey) ?? []
  }
}
