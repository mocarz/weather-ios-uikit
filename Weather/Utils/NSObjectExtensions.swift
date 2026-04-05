//
//  NSObjectExtensions.swift
//  Weather
//
//  Created by Michal Mocarski on 11/04/2026.
//

import Foundation

extension NSObject {
  class var nameOfClass: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}
