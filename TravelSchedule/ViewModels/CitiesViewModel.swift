//
//  CitiesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation

final class CitiesViewModel: ObservableObject {
    
    @Published var cities: [CityModel]
    
    init() {
        self.cities = [
            
            CityModel(
                name: "Москва",
                stations: ["Киевский вокзал",
                           "Курский вокзал",
                           "Ярославский вокзал",
                           "Белорусский вокзал"]),
            CityModel(
                name: "Санкт-Петербург",
                stations: [
                    "Московский вокзал",
                    "Ладожский вокзал"]),
            
            CityModel(
                name: "Сочи",
                stations: [
                    "Морской вокзал",
                    "Центральный вокзал",
                    "Южный вокзал"]),
            
            CityModel(
                name: "Омск",
                stations: ["Омский вокзал"]),
            
            CityModel(
                name: "Гадюкино",
                stations: [])]
    }
    
    func searchCityResult(searchCity: String) -> [CityModel] {
        if searchCity.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.lowercased().contains(searchCity.lowercased())
            }
        }
    }
    
}

