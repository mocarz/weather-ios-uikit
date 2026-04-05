//
//  LocationsPersistedStoreTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import XCTest

@testable import Weather

final class LocationsPersistedStoreTests: XCTestCase {

  // MARK: - Properties

  private var sut: LocationsPersistedStore!
  private var userDefaults: MockUserDefaults!

  // MARK: - Setup / Teardown

  override func setUp() {
    super.setUp()
    userDefaults = MockUserDefaults()
    sut = LocationsPersistedStore(userDefaults: userDefaults)
  }

  override func tearDown() {
    sut = nil
    userDefaults = nil
    super.tearDown()
  }

  func test_readLocations_returnsAllStoredLocations() {
    let sut = LocationsPersistedStore(
      userDefaults: userDefaults, initialLocations: ["KAUS", "KLAX", "KJFK"])
    XCTAssertEqual(sut.readLocations(), ["KAUS", "KLAX", "KJFK"])
  }

  func test_appendLocation_multipleNewLocations_orderedMostRecentFirst() {
    sut.appendLocation(location: "KAUS")
    sut.appendLocation(location: "KLAX")
    sut.appendLocation(location: "KJFK")
    XCTAssertEqual(sut.readLocations(), ["KJFK", "KLAX", "KAUS"])
  }
}
