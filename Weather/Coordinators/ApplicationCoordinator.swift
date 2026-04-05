//
//  ApplicationCoordinator.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
  private let router: RouterProtocol
  private let weatherDataSource: WeatherDetailsDataSourceProtocol
  private let locationsPersistedStore: LocationsPersistedStoreProtocol

  init(
    router: RouterProtocol,
    weatherDataSource: WeatherDetailsDataSourceProtocol,
    locationsPersistedStore: LocationsPersistedStoreProtocol
  ) {
    self.router = router
    self.weatherDataSource = weatherDataSource
    self.locationsPersistedStore = locationsPersistedStore
  }

  override func start() {
    showLocationSelectionPage()
  }

  private func showLocationSelectionPage() {
    let locations = self.locationsPersistedStore.readLocations()
    let dataSource = LocationsSelectionDataSource(locations: locations)

    let viewController = LocationSelectionViewController.instantiateFromXibWith(
      dataSource: dataSource)

    viewController.onSelectLocation = { [weak self] location in
      guard let self else { return }
      self.locationsPersistedStore.appendLocation(location: location)

      self.showDetailsView(
        location: location,
        didFinishTransition: { [weak viewController] in
          dataSource.updateLocations(self.locationsPersistedStore.readLocations())
          viewController?.reloadLocations()
        })
    }

    router.set(viewController)
  }

  private func showDetailsView(location: Location, didFinishTransition: (() -> Void)? = nil) {
    let viewController = WeatherDetailsViewController.instantiateFromXibWith(
      location: location,
      weatherDataSource: self.weatherDataSource)
    router.push(viewController, animated: true, completion: didFinishTransition)
  }
}
