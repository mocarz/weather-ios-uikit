//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Michal Mocarski on 10/04/2026.
//

import Foundation

final class WeatherDetailsDataSource: WeatherDetailsDataSourceProtocol {
  private let weatherApiClient: WeatherApiClientProtocol
  private let cacheManager: CacheManagerProtocol
  private let defaultCacheExpiration: TimeInterval

  init(
    weatherApiClient: WeatherApiClientProtocol, cacheManager: CacheManagerProtocol,
    defaultCacheExpiration: TimeInterval = 3600
  ) {
    self.weatherApiClient = weatherApiClient
    self.cacheManager = cacheManager
    self.defaultCacheExpiration = defaultCacheExpiration
  }

  func getWeatherReport(
    airportIdentifier: String, allowReadFromCache: Bool,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void
  ) {
    if allowReadFromCache,
      let cachedItem: WeatherReportDTO = self.cacheManager.get(airportIdentifier)
    {
      print("cache hit for location: \(airportIdentifier)")
      completion(.success(cachedItem))
      return
    }
    
    self.weatherApiClient.getWeatherReport(
      airportIdentifier: airportIdentifier,
      completion: { [weak self] result in
        guard let self else { return }

        switch result {
        case .success(let dto):
          self.cacheManager.set(
            airportIdentifier, value: dto, expiresIn: self.defaultCacheExpiration)
          completion(.success(dto))
        case .failure(let error):
          completion(.failure(error))
        }
      })
  }

  func prepareCurrentWeatherTextReport(conditions: Conditions) -> String {
    var weatherFeatures: [String] = []

    weatherFeatures.append("Airport: \(conditions.ident.uppercased())")

    weatherFeatures.append("Text: \(conditions.text ?? "N/A")")

    let tempText = conditions.tempC.map { String($0) } ?? "N/A"
    weatherFeatures.append("Temperature (C): \(tempText)")

    let pressureText = conditions.pressureHg.map { String($0) } ?? "N/A"
    weatherFeatures.append("Pressure (Hg): \(pressureText)")

    let humidityText = conditions.relativeHumidity.map { String($0) } ?? "N/A"
    weatherFeatures.append("Humidity (%): \(humidityText)")

    let windSpeedText = String(conditions.wind.speedKts)
    weatherFeatures.append("Wind Speed (kts): \(windSpeedText)")

    let windDirectionText = conditions.wind.direction.map { String($0) } ?? "N/A"
    weatherFeatures.append("Wind Direction (degrees): \(windDirectionText)")

    return weatherFeatures.joined(separator: "\n")
  }

  func prepareTextWeatherForecast(forecast: Forecast) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short

    var weatherFeatures: [String] = []

    weatherFeatures.append("Airport: \(forecast.ident.uppercased())")

    let dateStartString = dateFormatter.string(from: forecast.period.dateStart)
    let dateEndString = dateFormatter.string(from: forecast.period.dateEnd)
    weatherFeatures.append("Period: \(dateStartString) - \(dateEndString)")

    let conditionTexts = forecast.conditions.map { forecastCondition -> String in
      let windDirectionText = forecastCondition.wind.direction.map { String($0) } ?? "N/A"
      return [
        "Period: \(dateFormatter.string(from: forecastCondition.period.dateStart)) - \(dateFormatter.string(from: forecastCondition.period.dateEnd))",
        "Text: \(forecastCondition.text)",
        "Wind Speed (kts): \(forecastCondition.wind.speedKts)",
        "Wind Direction (degrees): \(windDirectionText)",
      ].joined(separator: "\n")
    }
    weatherFeatures.append(contentsOf: conditionTexts)

    return weatherFeatures.joined(separator: "\n\n")
  }
}
