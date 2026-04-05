//
//  MockWeatherDetailsDataSource.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

@testable import Weather

final class MockWeatherDetailsDataSource: WeatherDetailsDataSourceProtocol {
  func getWeatherReport(
    airportIdentifier: String,
    allowReadFromCache: Bool,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void
  ) {}

  func prepareCurrentWeatherTextReport(conditions: Conditions) -> String { "" }
  func prepareTextWeatherForecast(forecast: Forecast) -> String { "" }
}
