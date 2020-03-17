//
//  CountryRow.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct CountryRow: View {
    
    var country: Country
    
    var body: some View {
        HStack {
            VStack {
                Text(country.flag).font(Font.system(size: 48))
            }.frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 3)
            )
            Spacer()
            VStack {
                Text(country.name).font(.title)
                HStack {
                    VStack {
                        Image(systemName: "person.fill")
                        Text(country.cases.description)
                    }
                    VStack {
                        Image(systemName: "person.badge.minus")
                        Text(country.deaths.description)
                            .foregroundColor(.red)
                    }
                    VStack {
                        Image(systemName: "person.badge.plus")
                        Text(country.recovered.description)
                            .foregroundColor(.green)
                    }
                }.font(.headline)
            }.layoutPriority(100)
            Spacer()
        }
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: Country(name: "Spain", cases: 70, deaths: 30, recovered: 10))
    }
}
