//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import UIKit

final class WeatherDetailsViewController: BaseViewController {

  private enum WeatherDisplayMode: Int {
    case current = 0
    case forecast = 1
  }

  @IBOutlet weak var weatherTextView: UITextView!
  @IBOutlet weak var refreshTimerSwitch: UISwitch!
  @IBOutlet weak var weatherTypeSegmentControl: UISegmentedControl!

  private var weatherDetailsDataSource: WeatherDetailsDataSourceProtocol!
  private var weatherReport: WeatherReportDTO?
  private var location: Location!
  private var refreshTimer: Timer?

  static func instantiateFromXibWith(
    location: Location, weatherDataSource: WeatherDetailsDataSourceProtocol
  )
    -> Self
  {
    let viewController = Self.instantiateFromXib()
    viewController.weatherDetailsDataSource = weatherDataSource
    viewController.location = location
    return viewController
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    guard weatherDetailsDataSource != nil, location != nil else {
      assertionFailure(
        "WeatherDetailsViewController must be instantiated via instantiateFromXibWith(location:weatherDataSource:)"
      )
      return
    }

    fetchWeather(allowReadFromCache: true)
    self.configureRefreshTimer(isOn: self.refreshTimerSwitch.isOn)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    cancelTimer()
  }

  @IBAction func timerSwitchValueChanged(_ uiSwitch: UISwitch) {
    self.configureRefreshTimer(isOn: uiSwitch.isOn)
  }

  @IBAction func weatherTypeValueChanged(_ segmentedControl: UISegmentedControl) {
    guard let weatherReport = self.weatherReport else { return }
    showWeather(weatherResponse: weatherReport)
  }

  private func fetchWeather(allowReadFromCache: Bool) {
    let location: Location = self.location

    self.weatherDetailsDataSource.getWeatherReport(
      airportIdentifier: location, allowReadFromCache: allowReadFromCache,
      completion: { [weak self] result in
        guard let self else { return }
        switch result {
        case .success(let weatherResponse):
          self.weatherReport = weatherResponse
          self.showWeather(weatherResponse: weatherResponse)
        case .failure(let error):
          self.showAlert(
            title: "Error", message: "Failed to fetch weather: \(error.localizedDescription)")
        }
      })
  }

  private func showWeather(weatherResponse: WeatherReportDTO) {
    guard let mode = WeatherDisplayMode(rawValue: weatherTypeSegmentControl.selectedSegmentIndex)
    else { return }
    switch mode {
    case .current:
      self.showCurrentWeather(conditions: weatherResponse.report.conditions)
    case .forecast:
      self.showWeatherForecast(forecast: weatherResponse.report.forecast)
    }
  }

  private func showCurrentWeather(conditions: Conditions) {
    let textWeather = self.weatherDetailsDataSource.prepareCurrentWeatherTextReport(
      conditions: conditions)
    self.weatherTextView.text = textWeather
  }

  private func showWeatherForecast(forecast: Forecast) {
    let textWeather = self.weatherDetailsDataSource.prepareTextWeatherForecast(forecast: forecast)
    self.weatherTextView.text = textWeather
  }

  private func configureRefreshTimer(isOn: Bool) {
    if isOn {
      self.startRefreshTimer()
    } else {
      self.cancelTimer()
    }
  }

  private func startRefreshTimer() {
    self.refreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
      [weak self] _ in
      self?.fetchWeather(allowReadFromCache: false)
    }
  }

  private func cancelTimer() {
    self.refreshTimer?.invalidate()
    self.refreshTimer = nil
  }
}

extension WeatherDetailsViewController: XibInstantiable {

}
