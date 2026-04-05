//
//  CacheManagerProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//
import Foundation

protocol CacheManagerProtocol {
  func set<T>(_ key: String, value: T, expiresIn: TimeInterval?)
  func get<T>(_ key: String) -> T?
}
