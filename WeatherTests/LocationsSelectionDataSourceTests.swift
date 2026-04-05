//
//  LocationsSelectionDataSourceTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import UIKit
import XCTest

@testable import Weather

final class LocationsSelectionDataSourceTests: XCTestCase {

  private var sut: LocationsSelectionDataSource!
  private var tableView: UITableView!

  override func setUp() {
    super.setUp()
    sut = LocationsSelectionDataSource(locations: [])
    tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: LabelRow.cellIdentifier)
    tableView.dataSource = sut
  }

  override func tearDown() {
    sut = nil
    tableView = nil
    super.tearDown()
  }

  func test_init_storesLocations() {
    let locations: [Location] = ["KAUS", "KLAX", "KJFK"]
    let sut = LocationsSelectionDataSource(locations: locations)
    XCTAssertEqual(sut.locations, locations)
  }

  func test_updateLocations_replacesExistingLocations() {
    sut.updateLocations(["KAUS", "KLAX"])
    XCTAssertEqual(sut.locations, ["KAUS", "KLAX"])
  }

  func test_numberOfRows_returnsCorrectCount() {
    sut.updateLocations(["KAUS", "KLAX", "KJFK"])
    let count = sut.tableView(tableView, numberOfRowsInSection: 0)
    XCTAssertEqual(count, 3)
  }

  func test_cellForRow_displaysCorrectLocation() {
    sut.updateLocations(["KAUS", "KLAX", "KJFK"])
    tableView.reloadData()
    let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
    XCTAssertEqual(cell.textLabel?.text, "KAUS")
  }

}
