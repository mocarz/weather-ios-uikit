//
//  PersistedStoreTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import XCTest

@testable import Weather

final class PersistedStoreTests: XCTestCase {
  private var peristedStore: PersistedStore!
  private var userDefaults: MockUserDefaults!

  override func setUp() {
    super.setUp()
    userDefaults = MockUserDefaults()
    peristedStore = PersistedStore(userDefaults: userDefaults, keyPrefix: "test")
  }

  override func tearDown() {
    userDefaults = nil
    peristedStore = nil
    super.tearDown()
  }

  func test_get_returnsNil_whenNothingStored() {
    let result: String? = peristedStore.get("missing_key")
    XCTAssertNil(result)
  }

  func test_get_returnsNil_forDifferentKey() {
    peristedStore.set("keyA", value: "hello")
    let result: String? = peristedStore.get("keyB")
    XCTAssertNil(result)
  }

  func test_set_andGet_returnsStoredString() {
    peristedStore.set("name", value: "Test")
    let result: String? = peristedStore.get("name")
    XCTAssertEqual(result, "Test")
  }

  func test_set_overwritesExistingValue() {
    peristedStore.set("key", value: "value1")
    peristedStore.set("key", value: "value2")
    let result: String? = peristedStore.get("key")
    XCTAssertEqual(result, "value2")
  }
}
