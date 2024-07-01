//
//  CitiesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation
import OpenAPIURLSession

final class CitiesViewModel: ObservableObject {
    
    @Published var cities: [CityModel] = []
    @Published var searchCity: String = ""
    
    init() {
        getStationsList()
        //        self.cities = [
        //            CityModel(
        //                name: "Москва",
        //                stations: ["Киевский вокзал",
        //                           "Курский вокзал",
        //                           "Ярославский вокзал",
        //                           "Белорусский вокзал"]),
        //            CityModel(
        //                name: "Гадюкино",
        //                stations: [])]
    }
    
    func searchCityResult() -> [CityModel] {
        if searchCity.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.lowercased().contains(searchCity.lowercased())
            }
        }
    }
    
    // Полный список станций
    func getStationsList() {
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
                                    let stationNames = settlement.stations?.map { station in
                                        if station.transport_type == "train",
                                           let stationName = station.title {
                                            return stationName
                                        } else {
                                            return("")
                                        }
                                    }.filter{$0 != ""}.sorted()
                                    
                                    let newSettlement = CityModel(code: "s9605487", name: cityName, stations: stationNames ?? [])
                                    cities.append(newSettlement)
                                }
                            }
                        }
                    }
                
                cities.sort {$0.name < $1.name}
                
                print(cities)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
}

