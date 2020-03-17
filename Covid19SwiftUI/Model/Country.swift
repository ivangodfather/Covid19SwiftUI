//
//  Country.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Country: Decodable, Identifiable {
    var id: String { name }
    
    let name: String
    let cases: Int
    let deaths: Int
    let recovered: Int
    
    var flag: String { name.flag }
    
    private enum CodingKeys: String, CodingKey {
        case name = "country"
        case cases
        case deaths
        case recovered
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        cases = Int(try container.decode(String.self, forKey: .cases).filter { $0.isNumber }) ?? 0
        deaths = Int(try container.decode(String.self, forKey: .deaths).filter { $0.isNumber }) ?? 0
        recovered = Int(try container.decode(String.self, forKey: .recovered).filter { $0.isNumber }) ?? 0
    }
}

extension Country {
    init(name: String, cases: Int, deaths: Int, recovered: Int) {
        self.name = name
        self.cases = cases
        self.deaths = deaths
        self.recovered = recovered
    }
}
