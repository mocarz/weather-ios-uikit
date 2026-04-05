//
//  MockRouter.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import UIKit

@testable import Weather

final class MockRouter: RouterProtocol {
  private(set) var setViewControllers: [UIViewController] = []
  private(set) var pushedViewControllers: [UIViewController] = []
  private(set) var pushCompletions: [(() -> Void)?] = []

  func set(_ viewController: UIViewController) {
    setViewControllers.append(viewController)
  }

  func set(_ viewController: UIViewController, animated: Bool) {
    setViewControllers.append(viewController)
  }

  func push(_ viewController: UIViewController) {
    pushedViewControllers.append(viewController)
  }

  func push(_ viewController: UIViewController, animated: Bool) {
    pushedViewControllers.append(viewController)
  }

  func push(_ viewController: UIViewController, completion: (() -> Void)?) {
    pushedViewControllers.append(viewController)
    pushCompletions.append(completion)
  }

  func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    pushedViewControllers.append(viewController)
    pushCompletions.append(completion)
  }

  func present(_ viewController: UIViewController) {}
  func present(_ viewController: UIViewController, animated: Bool) {}
  func dismiss() {}
  func dismiss(animated: Bool) {}
}
