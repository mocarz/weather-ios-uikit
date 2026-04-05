//
//  XibInstantiable.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

protocol XibInstantiable where Self: UIViewController {
  static func instantiateFromXib() -> Self
}

extension XibInstantiable {
  static func instantiateFromXib() -> Self {
    return Self(nibName: nameOfClass, bundle: Bundle(for: self))
  }
}
