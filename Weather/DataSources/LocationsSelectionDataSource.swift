//
//  LocationsSelectionDataSource.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

final class LocationsSelectionDataSource: NSObject, LocationsSelectionDataSourceProtocol {

  var locations: [Location]

  init(locations: [Location]) {
    self.locations = locations
  }

  func updateLocations(_ locations: [Location]) {
    self.locations = locations
  }
}

extension LocationsSelectionDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: LabelRow.cellIdentifier, for: indexPath)
    cell.textLabel?.text = locations[indexPath.row]
    return cell
  }
}
