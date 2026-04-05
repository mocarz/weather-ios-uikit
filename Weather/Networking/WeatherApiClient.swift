//
//  WeatherApiClient.swift
//  Weather
//
//  Created by Michal Mocarski on 08/04/2026.
//

import Foundation

enum WeatherApiError: Error {
  case invalidURL
  case networkError(Error)
  case unexpectedStatusCode(Int)
  case noData
  case decodingError(Error)
}

final class WeatherApiClient: WeatherApiClientProtocol {
  private let session: URLSession
  private let baseURL = "https://qa.foreflight.com/weather/report"

  init(session: URLSession = .shared) {
    self.session = session
  }

  func getWeatherReport(
    airportIdentifier: String,
    completion: @escaping (Result<WeatherReportDTO, Error>) -> Void
  ) {
    guard
      let url = URL(string: "\(baseURL)/\(airportIdentifier)")
    else {
      DispatchQueue.main.async { completion(.failure(WeatherApiError.invalidURL)) }
      return
    }

    var request = URLRequest(url: url)
    request.setValue("1", forHTTPHeaderField: "ff-coding-exercise")
    request.httpMethod = "GET"

    let task = session.dataTask(with: request) { data, response, error in
      if let error = error {
        DispatchQueue.main.async { completion(.failure(WeatherApiError.networkError(error))) }
        return
      }

      if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        DispatchQueue.main.async {
          completion(.failure(WeatherApiError.unexpectedStatusCode(http.statusCode)))
        }
        return
      }

      guard let data = data else {
        DispatchQueue.main.async { completion(.failure(WeatherApiError.noData)) }
        return
      }

      do {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(formatter)

        let res = try decoder.decode(WeatherReportDTO.self, from: data)
        DispatchQueue.main.async { completion(.success(res)) }
      } catch {
        DispatchQueue.main.async { completion(.failure(WeatherApiError.decodingError(error))) }
      }
    }

    task.resume()
  }
}
