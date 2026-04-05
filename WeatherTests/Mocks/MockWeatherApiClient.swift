//
//  MockWeatherApiClient.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

@testable import Weather

final class MockWeatherApiClient: WeatherApiClientProtocol {
  var resultToReturn: Result<WeatherReportDTO, Error> = .failure(URLError(.unknown))
  private(set) var getWeatherReportCallCount = 0
  private(set) var lastAirportIdentifier: String?

  func getWeatherReport(
    airportIdentifier: String,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void
  ) {
    getWeatherReportCallCount += 1
    lastAirportIdentifier = airportIdentifier
    completion(resultToReturn)
  }
}
