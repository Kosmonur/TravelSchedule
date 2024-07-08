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
    func search() async {
        routes.removeAll()
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = SearchService(
            client: client,
            apikey: apiKey
        )
        
        do {
            let routesData = try await service.search(from: fromStation.code,
                                                      to: toStation.code,
                                                      date:  date)
            
            routesData.segments?.forEach {segment in
                let carrier = segment.value1.thread?.carrier
                let has_transfer = segment.value1.has_transfers ?? false
                let transferTitle = has_transfer ?  "\(Constant.withTransfer)\(segment.value1.transfers?.first?.title ?? "")" : ""
                
                var transferDuration = 0
                segment.value1.details?.forEach {detail in
                    transferDuration += Int(detail.duration ?? 0)
                }
                
                let duration = has_transfer ? transferDuration : segment.value1.duration
                
                let currentCarrier = CarrierModel(logo: carrier?.logo ?? "",
                                                  name: carrier?.title ?? "",
                                                  email: carrier?.email ?? "",
                                                  phone: carrier?.phone ?? "")
                
                let currentRoute = RouteModel(transfer: transferTitle,
                                              date: getDateFromUTC(utc: segment.value2.arrival),
                                              startTime: getTimeFromUTC(utc: segment.value1.departure),
                                              endTime: getTimeFromUTC(utc: segment.value2.arrival),
                                              duration: getDuration(duration: duration),
                                              carrier: currentCarrier)
                
                routes.append(currentRoute)
                
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

