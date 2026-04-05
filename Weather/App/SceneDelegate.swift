//
//  SceneDelegate.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var applicationCoordinator: ApplicationCoordinator?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    self.window = window

    let navigationController = UINavigationController()
    window.rootViewController = navigationController

    let applicationCoordinator = createApplicationCoordinator(
      navigationController: navigationController)
    self.applicationCoordinator = applicationCoordinator

    applicationCoordinator.start()

    window.makeKeyAndVisible()
  }

  private func createApplicationCoordinator(navigationController: UINavigationController)
    -> ApplicationCoordinator
  {
    let router = RouterImp(navigationController: navigationController)
    let weatherApiClient = WeatherApiClient()
    let cacheManager = CacheManager()
    let weatherDataSource = WeatherDetailsDataSource(
      weatherApiClient: weatherApiClient, cacheManager: cacheManager)

    let initialLocations = ["KPWM", "KAUS"]

    let locationsPersistedStore = LocationsPersistedStore(initialLocations: initialLocations)

    let applicationCoordinator = ApplicationCoordinator(
      router: router, weatherDataSource: weatherDataSource,
      locationsPersistedStore: locationsPersistedStore)

    return applicationCoordinator
  }
}
