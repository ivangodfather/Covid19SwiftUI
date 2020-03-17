//
//  String+Flag.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension String {
    
    var flag: String {
        let countryCode = locale(for: self)
        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    private func locale(for fullCountryName : String) -> String {
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: "en")
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
            var foundLocale: String?
            fullCountryName.lowercased().split(separator: " ").forEach { splitCountry in
                if countryName?.lowercased().split(separator: " ").contains(splitCountry) ?? false {
                    foundLocale = localeCode
                }
            }
            if let foundLocale = foundLocale {
                return foundLocale
            }
        }
        return ""
    }
}
