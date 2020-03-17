//
//  CovidAPI.swift
//  Covid19SwiftUI
//
//  Created by Ivan Ruiz Monjo on 16/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

enum CovidError: Error {
    case serverError
}

final class CovidAPI {
    
    let url: URL
    
    init() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "interactive-static.scmp.com"
        urlComponents.path = "/sheet/wuhan/viruscases.json"
        guard let url = urlComponents.url else {
            fatalError()
        }
        self.url = url
    }
    
    func fetch() -> AnyPublisher<Result<[Country], CovidError>, Never> {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { Result<[Country], CovidError>.success($0.entries) }
            .eraseToAnyPublisher()
            .catch { error -> AnyPublisher<Result<[Country], CovidError> , Never>  in
                Just(Result.failure(CovidError.serverError)).eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


