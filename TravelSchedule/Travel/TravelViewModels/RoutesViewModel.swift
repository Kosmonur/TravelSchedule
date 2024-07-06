//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation
import OpenAPIURLSession

final class RoutesViewModel: ObservableObject {
    
    @Published var isRedDotHide = true
    @Published var isMorningOn = true
    @Published var isDayOn = true
    @Published var isEveningOn = true
    @Published var isNightOn = true
    @Published var isTransfersOn = true
    
    @Published var routes: [RouteModel]
    @Published var carrierViewModel: CarrierViewModel
    
    init() {
        
        self.carrierViewModel = CarrierViewModel(logo: "https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png", name: "Северо-западная пригородная пассажирская компания", email: "i.lozgkina@yandex.ru", phone: "(812) 458-68-68")
        
        self.routes = [RouteModel(carrierName: "РЖД",
                                  logo: "rzhd",
                                  transfer: "С пересадкой в Костроме",
                                  date: "14 января",
                                  startTime: "22:30",
                                  endTime: "08:15",
                                  duration: "20 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "ФГК",
                                  logo: "fgk",
                                  transfer: "",
                                  date: "15 января",
                                  startTime: "11:15",
                                  endTime: "15:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "Урал логистика",
                                  logo: "uralLog",
                                  transfer: "",
                                  date: "16 января",
                                  startTime: "12:30",
                                  endTime: "21:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       RouteModel(carrierName: "РЖД",
                                  logo: "rzhd",
                                  transfer: "С пересадкой в Костроме",
                                  date: "14 января",
                                  startTime: "22:30",
                                  endTime: "08:15",
                                  duration: "20 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "ФГК",
                                  logo: "fgk",
                                  transfer: "",
                                  date: "15 января",
                                  startTime: "01:15",
                                  endTime: "09:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "Урал логистика",
                                  logo: "uralLog",
                                  transfer: "",
                                  date: "16 января",
                                  startTime: "12:30",
                                  endTime: "21:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       RouteModel(carrierName: "РЖД",
                                  logo: "rzhd",
                                  transfer: "С пересадкой в Костроме",
                                  date: "14 января",
                                  startTime: "22:30",
                                  endTime: "08:15",
                                  duration: "20 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "ФГК",
                                  logo: "fgk",
                                  transfer: "",
                                  date: "15 января",
                                  startTime: "01:15",
                                  endTime: "09:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68")),
                       
                       RouteModel(carrierName: "Урал логистика",
                                  logo: "uralLog",
                                  transfer: "",
                                  date: "16 января",
                                  startTime: "12:30",
                                  endTime: "21:00",
                                  duration: "9 часов",
                                  carrier: CarrierModel(logo: " https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png",
                                                        name: "Северо-западная пригородная пассажирская компания",
                                                        email: "i.lozgkina@yandex.ru",
                                                        phone: "(812) 458-68-68"))
        ]
        
        self.search()
        
    }
    
    func filteredRoutes() -> [RouteModel] {
        
        let morningRoutes = isMorningOn ? routes.filter { route in
            if let startHour = Int(route.startTime.prefix(2)),
               (6 ..< 12).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let dayRoutes = isDayOn ? routes.filter { route in
            if let startHour = Int(route.startTime.prefix(2)),
               (12 ..< 18).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let eveningRoutes = isEveningOn ? routes.filter { route in
            if let startHour = Int(route.startTime.prefix(2)),
               (18 ..< 24).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let nightyRoutes = isNightOn ? routes.filter { route in
            if let startHour = Int(route.startTime.prefix(2)),
               (0 ..< 6).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        var outputRoutes = [morningRoutes, dayRoutes, eveningRoutes, nightyRoutes].flatMap {$0}
        outputRoutes.sort(by: { $0.date.prefix(2) < $1.date.prefix(2) })
        
        return(isTransfersOn ? outputRoutes : outputRoutes.filter {
            $0.transfer == ""})
    }
    
    func setRedDotStatus() {
        isRedDotHide = isMorningOn && isDayOn && isEveningOn && isNightOn && isTransfersOn
    }
    
    // Расписание рейсов между станциями
    func search() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = SearchService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let route = try await service.search(from: "s9602498",
                                                     to: "s9603596",
                                                     date:  "2024-07-03")
                
                
                
                print ("\nРасписание рейсов между станциями\n")
                print(route)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

