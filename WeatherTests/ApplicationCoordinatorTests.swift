//
//  ApplicationCoordinatorTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import UIKit
import XCTest

@testable import Weather

final class ApplicationCoordinatorTests: XCTestCase {

  private var sut: ApplicationCoordinator!
  private var router: MockRouter!
  private var weatherDataSource: MockWeatherDetailsDataSource!
  private var locationsPersistedStore: MockLocationsPersistedStore!

  override func setUp() {
    super.setUp()
    router = MockRouter()
    weatherDataSource = MockWeatherDetailsDataSource()
    locationsPersistedStore = MockLocationsPersistedStore()
    sut = ApplicationCoordinator(
      router: router,
      weatherDataSource: weatherDataSource,
      locationsPersistedStore: locationsPersistedStore
    )
  }

  override func tearDown() {
    sut = nil
    router = nil
    weatherDataSource = nil
    locationsPersistedStore = nil
    super.tearDown()
  }

  func test_start_setsLocationSelectionViewController() {
    sut.start()
    XCTAssertEqual(router.setViewControllers.count, 1)
    XCTAssertTrue(
      router.setViewControllers.first is LocationSelectionViewController,
      "Expected LocationSelectionViewController to be set on the router"
    )
  }

  func test_start_doesNotPushAnyViewController() {
    sut.start()
    XCTAssertTrue(router.pushedViewControllers.isEmpty)
  }

  func test_selectingLocation_pushesWeatherDetailsViewController() {
    sut.start()
    let locationVC = router.setViewControllers.first as? LocationSelectionViewController
    locationVC?.onSelectLocation?("KAUS")

    XCTAssertEqual(router.pushedViewControllers.count, 1)
    XCTAssertTrue(
      router.pushedViewControllers.first is WeatherDetailsViewController,
      "Expected WeatherDetailsViewController to be pushed after selecting a location"
    )
  }

  func test_selectingLocation_appendsLocationToPersistedStore() {
    sut.start()
    let locationVC = router.setViewControllers.first as? LocationSelectionViewController
    locationVC?.onSelectLocation?("KAUS")

    XCTAssertEqual(locationsPersistedStore.readLocations(), ["KAUS"])
  }

  func test_selectingMultipleLocations_appendsAllToPersistedStore() {
    sut.start()
    let locationVC = router.setViewControllers.first as? LocationSelectionViewController
    locationVC?.onSelectLocation?("KAUS")
    locationVC?.onSelectLocation?("KLAX")

    XCTAssertEqual(locationsPersistedStore.readLocations().first, "KLAX")
    XCTAssertEqual(locationsPersistedStore.readLocations().count, 2)
  }

  func test_didFinishTransition_isPassedToRouter() {
    sut.start()
    let locationVC = router.setViewControllers.first as? LocationSelectionViewController
    locationVC?.onSelectLocation?("KAUS")

    XCTAssertFalse(
      router.pushCompletions.isEmpty,
      "Expected a completion block to be passed to the router push"
    )
  }

}
