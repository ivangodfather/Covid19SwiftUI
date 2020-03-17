//
//  MainViewViewModel.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

final class MainViewViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    @Published var errorMsg: String?
    @Published var isLoading = false
    
    private let api: CovidAPI
    private var subscriptions = Set<AnyCancellable>()
    private let subject = PassthroughSubject<(), Never>()
    
    init(covidAPI: CovidAPI = CovidAPI()) {
        self.api = covidAPI
        let result =
            subject
            .map { self.api.fetch() }
            .switchToLatest()
            .map { result -> ([Country], String?) in
                switch result {
                case.success(let countries):
                    return (countries.sorted(by: { $0.cases > $1.cases }), nil)
                case .failure(_):
                    return ([], "There was an error fetching the data")
                }
                }
            .share()
            .eraseToAnyPublisher()
        subject.map { _ in true }.assign(to: \.isLoading, on: self).store(in: &subscriptions)
        result.map { $0.0 }.assign(to: \.countries, on: self).store(in: &subscriptions)
        result.map { $0.1 }.assign(to: \.errorMsg, on: self).store(in: &subscriptions)
        result.map { _ in false }.assign(to: \.isLoading, on: self).store(in: &subscriptions)
    }
    
    func fetch() {
        subject.send()
    }
    
}
