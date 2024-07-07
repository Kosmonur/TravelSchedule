//
//  CitiesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation
import OpenAPIURLSession

@MainActor
final class CitiesViewModel: ObservableObject {
    
    @Published var cities: [CityModel] = []
    @Published var searchCity: String = ""
    
    func searchCityResult() -> [CityModel] {
        if searchCity.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.lowercased().contains(searchCity.lowercased())
            }
        }
    }
    
    func getStationsList() {
        cities.removeAll()
        
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = StationsListService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let stationsList = try await service.getStationsList()
                let decodeList = try await Data(collecting: stationsList, upTo: 50*1024*1024)
                let allStations = try JSONDecoder().decode(StationsList.self, from: decodeList)
                
                allStations.countries?.filter {$0.title == "Россия"}
                    .forEach {country in
                        country.regions?.forEach { region in
                            region.settlements?.forEach { settlement in
                                if let cityName = settlement.title,
                                   cityName != "" {
                                    var stations: [StationModel] = []
                                    settlement.stations?.forEach { station in
                                        if station.transport_type == "train",
                                           let stationName = station.title,
                                           stationName != "" {
                                            let code = station.codes?.yandex_code ?? ""
                                            stations.append(StationModel(name: stationName, code: code))
                                        }
                                    }
                                    if !stations.isEmpty {
                                        let newSettlement = CityModel(name: cityName, stations: stations.sorted{$0.name < $1.name})
                                        cities.append(newSettlement)
                                    }
                                }
                            }
                        }
                    }
                cities.sort {$0.name < $1.name}
                
//                print(cities)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
}

