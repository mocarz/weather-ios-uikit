//
//  UINavigationControllerExtensions.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

extension UINavigationController {

  public func pushViewController(
    viewController: UIViewController,
    animated: Bool,
    completion: (() -> Void)?
  ) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }
}
