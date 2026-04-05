//
//  PersistedStoreProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

protocol PersistedStoreProtocol {
  func set<T>(_ key: String, value: T)
  func get<T>(_ key: String) -> T?
}
