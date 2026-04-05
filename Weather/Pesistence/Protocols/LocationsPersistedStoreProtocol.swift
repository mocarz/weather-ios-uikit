//
//  LocationsPersistedStoreProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

protocol LocationsPersistedStoreProtocol: PersistedStoreProtocol {
  func appendLocation(location: Location)
  func readLocations() -> [Location]
}
