//
//  LocationsSelectionDataSourceProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 12/04/2026.
//

import UIKit

protocol LocationsSelectionDataSourceProtocol: UITableViewDataSource {
  var locations: [Location] { get }
  func updateLocations(_ locations: [Location])
}
