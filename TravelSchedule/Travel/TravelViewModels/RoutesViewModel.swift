//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation
import OpenAPIURLSession

@MainActor
final class RoutesViewModel: ObservableObject {
    
    @Published var isRedDotHide = true
    @Published var isMorningOn = true
    @Published var isDayOn = true
    @Published var isEveningOn = true
    @Published var isNightOn = true
    @Published var isTransfersOn = true
    @Published var routes: [RouteModel] = []
    
    private var fromStation: StationModel
    private var toStation: StationModel
    private var date: String
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(fromStation: StationModel, toStation: StationModel) {
        
        self.fromStation = fromStation
        self.toStation = toStation
        self.date = formatter.string(from: Date())

//        self.routes = [RouteModel(transfer: "С пересадкой в Костроме",
//                                  date: "14 января",
//                                  startTime: "22:30",
//                                  endTime: "08:15",
//                                  duration: "23 ч 35 мин",
//                                  carrier: CarrierModel(logo: "",
//                                                        name: "Северо-западная пригородная пассажирская компания",
//                                                        email: "i.lozgkina@yandex.ru",
//                                                        phone: "(812) 458-68-68")),
//                       RouteModel(transfer: "",
//                                                 date: "15 января",
//                                                 startTime: "00:21",
//                                                 endTime: "09:10",
//                                                 duration: "15 ч 35 мин",
//                                                 carrier: CarrierModel(logo: "https://yastat.net/s3/rasp/media/data/company/logo/doss.jpg",
//                                                                       name: "Северо-западная пригородная пассажирская компания",
//                                                                       email: "i.lozgkina@yandex.ru",
//                                                                       phone: "(812) 458-68-68")),
//                       
//        ]
        
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
    
    func getTitle() -> String {
        "\(fromStation.name) → \(toStation.name)"
    }
    
    func getTimeFromUTC(utc: String?) -> String {
        guard let utc else {return ""}
        return String(utc.dropFirst(11).dropLast(9))
    }
    
    func getDateFromUTC(utc: String?) -> String {
        guard let utc else {return ""}
        let day = String(utc.dropFirst(8).dropLast(15))
        let monthNumber = Int(String(utc.dropFirst(5).dropLast(18))) ?? 1
        let monthName = Constant.monthNames[monthNumber-1]
        return "\(day) \(monthName)"
    }
    
    func getDuration(duration: Int?) -> String {
        guard let duration else {return ""}
        return (duration < 86400 ? "\(duration / 3600)ч \((duration % 3600) / 60)мин" : "\(duration / 86400)дн \((duration % 86400) / 3600)ч")
    }
    
    // Расписание рейсов между станциями
    func search() {
        routes.removeAll()
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
                let routesData = try await service.search(from: fromStation.code,
                                                          to: toStation.code,
                                                          date:  date)
                
                routesData.interval_segments?.forEach{intseg in
                    print(intseg)

                }
                
                routesData.segments?.forEach {segment in
                    
                    let carrier = segment.value1.thread?.carrier
                    
                    let currentCarrier = CarrierModel(logo: carrier?.logo ?? "",
                                                      name: carrier?.title ?? "",
                                                      email: carrier?.email ?? "",
                                                      phone: carrier?.phone ?? "")
                    
                    let currentRoute = RouteModel(transfer: "",
                                                  date: getDateFromUTC(utc: segment.value2.arrival),
                                                  startTime: getTimeFromUTC(utc: segment.value1.departure),
                                                  endTime: getTimeFromUTC(utc: segment.value2.arrival),
                                                  duration: getDuration(duration: segment.value1.duration),
                                                  carrier: currentCarrier)
                    
                    routes.append(currentRoute)
                    
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

