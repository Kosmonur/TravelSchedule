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
    private var currentTimeDate = Date()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private let localISOFormatter: ISO8601DateFormatter = {
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }()
    
    init(fromStation: StationModel, toStation: StationModel) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.date = formatter.string(from: currentTimeDate)
    }
    
    func filteredRoutes() -> [RouteModel] {
        
        let nightyRoutes = isNightOn ? routes.filter { route in
            if let startHour = Int(route.startTime.prefix(2)),
               (.zero ..< 6).contains(startHour) {
                return true
            } else { return false }
        } : []
        
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
        
        var outputRoutes = [nightyRoutes, morningRoutes, dayRoutes, eveningRoutes].flatMap {$0}
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
    
    func search() async {
        routes.removeAll()
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = SearchService(
            client: client,
            apikey: ApiConstants.apiKey
        )
        
        do {
            let routesData = try await service.search(from: fromStation.code,
                                                      to: toStation.code,
                                                      date:  date)
            
            routesData.segments?.forEach {segment in
                let carrier = segment.value1.thread?.carrier
                let has_transfer = segment.value1.has_transfers ?? false
                let transferTitle = has_transfer ?  "\(Constant.withTransfer)\(segment.value1.transfers?.first?.title ?? "")" : ""
                
                var transferDuration: Int = .zero
                segment.value1.details?.forEach {detail in
                    transferDuration += Int(detail.duration ?? .zero)
                }
                
                checkAndAppendRoute(segment, has_transfer, transferDuration, carrier, transferTitle)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func checkAndAppendRoute(_ segment: Components.Schemas.Segment, _ has_transfer: Bool, _ transferDuration: Int, _ carrier: Components.Schemas.Carrier?, _ transferTitle: String) {
        let departureMoment = segment.value1.departure ?? ""
        let departureTimeDate = localISOFormatter.date(from: departureMoment) ?? currentTimeDate
        
        let duration = has_transfer ? transferDuration : segment.value1.duration
        
        let currentCarrier = CarrierModel(logo: carrier?.logo ?? "",
                                          name: carrier?.title ?? "",
                                          email: carrier?.email ?? "",
                                          phone: carrier?.phone ?? "")
        
        let currentRoute = RouteModel(transfer: transferTitle,
                                      date: getDateFromUTC(utc: departureMoment),
                                      startTime: getTimeFromUTC(utc: departureMoment),
                                      endTime: getTimeFromUTC(utc: segment.value2.arrival),
                                      duration: getDuration(duration: duration),
                                      carrier: currentCarrier)
        
        if departureTimeDate > currentTimeDate {
            routes.append(currentRoute)
        }
    }
    
    private func getTimeFromUTC(utc: String?) -> String {
        guard let utc else {return ""}
        return String(utc.dropFirst(11).dropLast(9))
    }
    
    private func getDateFromUTC(utc: String?) -> String {
        guard let utc else {return ""}
        let day = String(utc.dropFirst(8).dropLast(15))
        let monthNumber = Int(String(utc.dropFirst(5).dropLast(18))) ?? 1
        let monthName = Constant.monthNames[monthNumber-1]
        return "\(day) \(monthName)"
    }
    
    private func getDuration(duration: Int?) -> String {
        guard let duration else {return ""}
        let secInMin = 60
        let secInHour = 3600
        let secInDay = 86400
        return (duration < secInDay ? "\(duration / secInHour)ч \((duration % secInHour) / secInMin)мин" : "\(duration / secInDay)дн \((duration % secInDay) / secInHour)ч")
    }
}

