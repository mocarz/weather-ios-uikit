//
//  CacheManagerTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import XCTest

@testable import Weather

final class CacheManagerTests: XCTestCase {

  private var cacheManager: CacheManager!

  override func setUp() {
    super.setUp()
    cacheManager = CacheManager()
  }

  override func tearDown() {
    cacheManager = nil
    super.tearDown()
  }

  func test_get_returnsNil_whenNothingStored() {
    let result: String? = cacheManager.get("missing_key")
    XCTAssertNil(result)
  }

  func test_set_andGet_returnsStoredValue() {
    cacheManager.set("key", value: "hello", expiresIn: nil)
    let result: String? = cacheManager.get("key")
    XCTAssertEqual(result, "hello")
  }
}
