//
//  InfoView.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct InfoView: View {
    
    @Binding var isPresented: Bool
    
    var doneButton: some View {
        return Button(action: {
            self.isPresented = false
        }) {
            Text("Done").bold()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("What this is about")) {
                    VStack {
                        Text("This app shows information on the spread of the COVID-19 virus. The information I show is not my property but it comes from official sources.\n Its purpose is purely for learning SwiftUI and Combine frameworks.").minimumScaleFactor(0.5)
                    }
                }
                Section(header: Text("Who I am")) {
                    Text("I'm Ivan Ruiz, an iOS developer starting to use Combine and SwiftUI").minimumScaleFactor(0.5)
                }
                Section(footer: Text("Version 0.1 - March 17, 2020")) { EmptyView() }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("About")
                .navigationBarItems(trailing: doneButton)
        }
    }
}


struct InfoView_Preview: PreviewProvider {
    static var previews: some View {
        return InfoView(isPresented: .constant(true))
    }
}
