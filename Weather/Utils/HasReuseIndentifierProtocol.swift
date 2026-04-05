//
//  HasReuseIndentifierProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

protocol HasReuseIndentifierProtocol {
  static var reuseIdentifier: String { get }
}

extension HasReuseIndentifierProtocol {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
