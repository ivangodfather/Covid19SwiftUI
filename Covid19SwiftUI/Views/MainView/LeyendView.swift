//
//  LeyendView.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct LeyendView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text("Cases").font(.body)
            Spacer()
            Image(systemName: "person.badge.minus")
            Text("Deaths").font(.body)
            Spacer()
            Image(systemName: "person.badge.plus")
            Text("Recovered").font(.body)
        }
    }
}

struct LeyendView_Previews: PreviewProvider {
    static var previews: some View {
        LeyendView()
    }
}
