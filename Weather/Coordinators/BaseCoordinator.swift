//
//  BaseCoordinator.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

class BaseCoordinator: CoordinatorProtocol {

  var childCoordinators: [CoordinatorProtocol] = []

  func start() {

  }

  // add only unique object
  func addDependency(_ coordinator: CoordinatorProtocol) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
  }

  func removeDependency(_ coordinator: CoordinatorProtocol?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
    else { return }

    // Clear child-coordinators recursively
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
      coordinator.childCoordinators
        .filter({ $0 !== coordinator })
        .forEach({ coordinator.removeDependency($0) })
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}
