//
//  WeatherDetailsDTO.swift
//  Weather
//
//  Created by Michal Mocarski on 12/04/2026.
//

import Foundation

struct WeatherReportDTO: Decodable {
  let report: Report
}

struct Report: Decodable {
  let conditions: Conditions
  let forecast: Forecast
  //  let windsAloft: WindsAloft
  //  let mos: MOS
  //  let atis: [ATIS]
}

struct Conditions: Decodable {
  let text: String?
  let ident: String
  let dateIssued: Date?
  let lat: Double?
  let lon: Double?
  let elevationFt: Double?
  let tempC: Double?
  let dewpointC: Double?
  let pressureHg: Double?
  let pressureHpa: Double?
  let reportedAsHpa: Bool?
  let densityAltitudeFt: Int?
  let relativeHumidity: Int?
  let flightRules: String
  let cloudLayers: [CloudLayer]
  let cloudLayersV2: [CloudLayer]
  let weather: [String]
  let visibility: Visibility
  let wind: Wind
  let remarks: Remarks?
  let longestRunway: Int?
}

struct CloudLayer: Decodable {
  let coverage: String
  let altitudeFt: Double
  let ceiling: Bool
  let type: String?
  let altitudeQualifier: Int?
}

struct Visibility: Decodable {
  let distanceSm: Double?
  let distanceMeter: Double?
  let distanceQualifier: Int?
  let prevailingVisSm: Double?
  let prevailingVisMeter: Double?
  let prevailingVisDistanceQualifier: Int?
  let visReportedInMetric: Bool?
}

struct Wind: Decodable {
  let speedKts: Double
  let gustSpeedKts: Double?
  let direction: Int?
  let variable: Bool
  let from: Int?
}

struct Remarks: Decodable {
  let precipitationDiscriminator: Bool?
  let humanObserver: Bool?
  let hourlyPrecipitation: Double?
  let temperature: Double?
  let dewpoint: Double?
  let lightning: [Lightning]?
  let weatherBeginEnds: [String: [[String: String]]]?
  let clouds: [RemarkCloud]?
  let obscuringLayers: [String]?
}

struct Lightning: Decodable {
  let type: [String]
  let distance: String
  let location: String
}

struct RemarkCloud: Decodable {
  let type: String
  let location: String
  let distance: String
}

struct Forecast: Decodable {
  let text: String
  let ident: String
  let dateIssued: Date?
  let period: Period
  let lat: Double?
  let lon: Double?
  let elevationFt: Double?
  let conditions: [ForecastCondition]
}

struct ForecastCondition: Decodable {
  let text: String
  let dateIssued: Date
  let lat: Double
  let lon: Double
  let elevationFt: Double
  let relativeHumidity: Int?
  let change: String?
  let flightRules: String
  let cloudLayers: [CloudLayer]
  let cloudLayersV2: [CloudLayer]
  let weather: [String]
  let visibility: Visibility
  let wind: Wind
  let period: Period
  let tempMinC: Double?
  let tempMaxC: Double?
  let dewpointMinC: Double?
  let dewpointMaxC: Double?
  let turbulence: [String]?
  let icing: [String]?
}

struct Period: Decodable {
  let dateStart: Date
  let dateEnd: Date
}
