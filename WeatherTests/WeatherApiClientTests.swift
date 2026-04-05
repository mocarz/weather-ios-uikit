//
//  WeatherApiClientTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 12/04/2026.
//

import XCTest

@testable import Weather

final class WeatherApiClientTests: XCTestCase {

  // MARK: - Properties

  private var sut: WeatherApiClient!
  private var session: URLSession!

  // MARK: - Setup / Teardown

  override func setUp() {
    super.setUp()
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    session = URLSession(configuration: config)
    sut = WeatherApiClient(session: session)
  }

  override func tearDown() {
    MockURLProtocol.requestHandler = nil
    sut = nil
    session = nil
    super.tearDown()
  }

  private func makeResponse(statusCode: Int, url: URL) -> HTTPURLResponse {
    return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
  }

  private func makeValidJSON() -> Data {
    let json = """
      {
        "report": {
          "conditions": {
            "text": "Clear",
            "ident": "KAUS",
            "dateIssued": "2026-04-12T11:51:00+0000",
            "lat": 30.18,
            "lon": -97.68,
            "elevationFt": 489,
            "tempC": 22.0,
            "dewpointC": 10.0,
            "pressureHg": 29.92,
            "reportedAsHpa": false,
            "flightRules": "VFR",
            "cloudLayers": [],
            "cloudLayersV2": [],
            "weather": [],
            "visibility": { "distanceSm": 10.0 },
            "wind": { "speedKts": 10, "variable": false }
          },
          "forecast": {
            "text": "VFR",
            "ident": "KAUS",
            "dateIssued": "2026-04-12T11:51:00+0000",
            "lat": 30.18,
            "lon": -97.68,
            "elevationFt": 489,
            "period": {
              "dateStart": "2026-04-12T11:51:00+0000",
              "dateEnd": "2026-04-12T23:59:00+0000"
            },
            "conditions": []
          }
        }
      }
      """
    return Data(json.utf8)
  }

  private var validURL: URL { URL(string: "https://qa.foreflight.com/weather/report/KAUS")! }

  func test_getWeatherReport_succeedsOn200() {
    let expectation = expectation(description: "Completion called")
    MockURLProtocol.requestHandler = { request in
      return (self.makeResponse(statusCode: 200, url: request.url!), self.makeValidJSON())
    }
    sut.getWeatherReport(airportIdentifier: "KAUS") { result in
      if case .success = result {
        expectation.fulfill()
      } else {
        XCTFail("Expected success on 200, got \(result)")
      }
    }
    wait(for: [expectation], timeout: 10)
  }
}
