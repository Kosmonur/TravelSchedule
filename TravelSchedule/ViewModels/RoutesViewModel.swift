//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation

final class RoutesViewModel: ObservableObject {
    
    @Published var routes: [RouteModel]
    
    init() {
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
                                  duration: "9 часов"),
                       RouteModel(id: UUID(),
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
                                  duration: "9 часов"),
                       RouteModel(id: UUID(),
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

