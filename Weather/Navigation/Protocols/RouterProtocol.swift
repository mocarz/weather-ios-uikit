//
//  RouterProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

protocol RouterProtocol {
  func push(_ viewController: UIViewController)
  func push(_ viewController: UIViewController, animated: Bool)
  func push(_ viewController: UIViewController, completion: (() -> Void)?)
  func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
  func set(_ viewController: UIViewController)
  func set(_ viewController: UIViewController, animated: Bool)
  func present(_ viewController: UIViewController)
  func present(_ viewController: UIViewController, animated: Bool)
  func dismiss()
  func dismiss(animated: Bool)
}
