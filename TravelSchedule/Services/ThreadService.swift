//
//  ThreadService.swift
//  Travel_schedule
//
//  Created by Александр Пичугин on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.ThreadStations

protocol ThreadServiceProtocol {
    func getThreadStations(uid: String, date: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStations(uid: String, date: String) async throws -> Thread {
        let response = try await client.getThreadStations(query: .init(
            apikey: apikey,
            uid: uid,
            date: date
        ))
        return try response.ok.body.json
    }
}
