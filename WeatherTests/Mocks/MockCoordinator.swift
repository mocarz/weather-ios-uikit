//
//  MockCoordinator.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

@testable import Weather

final class MockCoordinator: CoordinatorProtocol {
  private(set) var startCallCount = 0

  func start() {
    startCallCount += 1
  }
}
