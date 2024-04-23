//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import Foundation

final class ScheduleViewModel: ObservableObject {
    
    @Published var cities: [CityModel]
    @Published var routes: [RouteModel]
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
        
        self.routes = [RouteModel(id: UUID(),
                                  carrierName: "РЖД",
                                  logo: "rzhd",
                                  transfer: "С пересадкой в Костроме",
                                  date: "14 января",
                                  startTime: "22:30",
                                  endTime: "08:15",
                                  duration: "20 часов"),
                       
                       RouteModel(id: UUID(),
                                  carrierName: "ФГК",
                                  logo: "fgk",
                                  transfer: "",
                                  date: "15 января",
                                  startTime: "01:15",
                                  endTime: "09:00",
                                  duration: "9 часов"),
                       
                       RouteModel(id: UUID(),
                                  carrierName: "Урал логистика",
                                  logo: "uralLog",
                                  transfer: "",
                                  date: "16 января",
                                  startTime: "12:30",
                                  endTime: "21:00",
                                  duration: "9 часов")
        ]
    }
}
