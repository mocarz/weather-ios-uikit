//
//  LocationSelectionViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

final class LocationSelectionViewController: UIViewController {
  @IBOutlet private weak var locationTextField: UITextField!
  @IBOutlet private weak var locationsTableView: UITableView!

  var onSelectLocation: ((Location) -> Void)?
  private var locationsDataSource: LocationsSelectionDataSourceProtocol!

  static func instantiateFromXibWith(dataSource: LocationsSelectionDataSourceProtocol) -> Self {
    let viewController = Self.instantiateFromXib()
    viewController.locationsDataSource = dataSource
    return viewController
  }

  @IBAction private func selectLocation(button: UIButton) {
    guard let text = self.locationTextField.text, !text.isEmpty else { return }
    self.onSelectLocation?(text)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    guard locationsDataSource != nil else {
      assertionFailure(
        "LocationSelectionViewController must be instantiated via instantiateFromXibWith(dataSource:)"
      )
      return
    }

    configureTableView()
  }

  func reloadLocations() {
    self.locationsTableView.reloadData()
  }

  private func configureTableView() {
    self.locationsTableView.backgroundColor = .clear
    self.locationsTableView.dataSource = locationsDataSource
    self.locationsTableView.delegate = self
    self.locationsTableView.register(
      UITableViewCell.self, forCellReuseIdentifier: LabelRow.cellIdentifier)
  }
}

extension LocationSelectionViewController: XibInstantiable {}

extension LocationSelectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.onSelectLocation?(self.locationsDataSource.locations[indexPath.row])
  }
}
