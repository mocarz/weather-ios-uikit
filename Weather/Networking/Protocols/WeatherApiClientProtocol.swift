//
//  DataManagerProtocol.swift
//  wattever
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

protocol WeatherApiClientProtocol {
  func getWeatherReport(
    airportIdentifier: String,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void)
}
