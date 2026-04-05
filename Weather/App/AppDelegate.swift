//
//  AppDelegate.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  private var applicationCoordinator: ApplicationCoordinator?
  //    private var dataManager: DataManager?
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(
      name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

}
