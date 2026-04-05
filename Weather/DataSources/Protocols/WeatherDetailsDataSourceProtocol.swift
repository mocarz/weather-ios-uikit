//
//  WeatherDataSourceProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 10/04/2026.
//

import Foundation

protocol WeatherDetailsDataSourceProtocol {
  func getWeatherReport(
    airportIdentifier: String, allowReadFromCache: Bool,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void)

  func prepareCurrentWeatherTextReport(conditions: Conditions) -> String

  func prepareTextWeatherForecast(forecast: Forecast) -> String
}
