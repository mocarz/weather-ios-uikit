//
//  ActivityIndicatorProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

protocol ActivityIndicatorProtocol {
  func showActivityIndicator(style: UIActivityIndicatorView.Style)
  func hideActivityIndicators()
}

extension ActivityIndicatorProtocol where Self: UIView {
  func showActivityIndicator(style: UIActivityIndicatorView.Style) {
    let activityIndicator = UIActivityIndicatorView(style: style)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.startAnimating()

    addSubview(activityIndicator)

    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }

  func hideActivityIndicators() {
    for subview in subviews {
      if let activityIndicator = subview as? UIActivityIndicatorView {
        activityIndicator.removeFromSuperview()
      }
    }
  }
}
