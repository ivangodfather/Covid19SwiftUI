//
//  ContentView.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewViewModel
    @State private var aboutIsPresented = false
    
    private var infoButton: some View {
        Button(action: { self.aboutIsPresented.toggle() }, label: {
            Image(systemName: "info.circle")
                .foregroundColor(.black)
                .font(.headline)
        })
    }
    
    private var refreshButton: some View {
        Button(action: { self.viewModel.fetch() }, label: {
            Image(systemName: "arrow.clockwise")
                .foregroundColor(.black)
                .font(.headline)
        })
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                Text("Loading...").font(.largeTitle)
            } else {
                List {
                    LeyendView()
                    ForEach(viewModel.countries) { country in
                        CountryRow(country: country)
                    }
                }
                .navigationBarItems(leading: infoButton,
                                    trailing: refreshButton)
                .navigationBarTitle("Covid-19 live status")
            }
        }.onAppear { self.viewModel.fetch() }
        .sheet(isPresented: self.$aboutIsPresented) {
            InfoView(isPresented: self.$aboutIsPresented)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewViewModel())
    }
}
