//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import Foundation

enum SelectionType {
    case departure
    case arrival
}

final class ScheduleViewModel: ObservableObject {
    
    @Published var cities: [CityModel]
    @Published var fromCity: String?
    @Published var fromStation: String?
    @Published var toCity: String?
    @Published var toStation: String?
    
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
}
