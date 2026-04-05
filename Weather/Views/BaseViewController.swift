//
//  BaseViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 12/04/2026.
//

import UIKit

class BaseViewController: UIViewController {

  func showErrorAlert(message: String) {
    showAlert(title: "Oops, something went wrong.", message: message)
  }

  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let action = UIAlertAction(title: "Dismiss", style: .default)
    alertController.addAction(action)

    present(alertController, animated: true, completion: nil)
  }
}
