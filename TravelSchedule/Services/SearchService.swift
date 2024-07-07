//
//  SearchService.swift
//  Travel_schedule
//
//  Created by Александр Пичугин on 09.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Routes = Components.Schemas.Routes

protocol SearchServiceProtocol {
    func search(from: String, to: String, date: String) async throws -> Routes
}

final actor SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func search(from: String, to: String, date: String) async throws -> Routes {
        let response = try await client.search(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}

