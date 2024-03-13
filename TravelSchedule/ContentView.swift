//
//  ContentView.swift
//  Travel_schedule
//
//  Created by Александр Пичугин on 09.03.2024.
//

import SwiftUI
import OpenAPIURLSession

enum Const {
    static let lat = 59.864177
    static let lng = 30.319163
    static let distance = 1
    static let fromStationCode = "c146"
    static let toStationCode = "c213"
    static let date = "2024-03-11"
    static let carrier = "112" // РЖД
    static let yaStationCode = "s9600213"
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            stations()
            settlement()
            search()
            carrier()
            schedule()
            thread()
            getCopyright()
            getStationsList()
        }
    }
    
    // Список ближайших станций
    func stations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let stations = try await service.getNearestStations(lat: Const.lat, lng: Const.lng, distance: Const.distance)
                print ("\nСписок ближайших станций\n")
                print(stations)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Ближайший город
    func settlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let settlement = try await service.getNearestSettlement(lat: Const.lat, lng: Const.lng)
                print ("\nБлижайший город\n")
                print(settlement)
            } catch {
                print("Error: \(error)")
            }
        }
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
                let route = try await service.search(from: Const.fromStationCode,
                                                     to: Const.toStationCode,
                                                     date: Const.date)
                print ("\nРасписание рейсов между станциями\n")
                print(route)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Информация о перевозчике
    func carrier() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let carrier = try await service.getCarrierInfo(code: Const.carrier)
                print ("\nИнформация о перевозчике\n")
                print(carrier)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Расписание рейсов по станции
    func schedule() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let schedule = try await service.getSchedule(station: Const.yaStationCode,
                                                             date: Const.date)
                print ("\nРасписание рейсов по станции\n")
                print(schedule)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Список станций следования
    func thread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let threadStation = try await service.getThreadStations(uid: "SU-1524_240310_c26_12", date: Const.date)
                print ("\nСписок станций следования\n")
                print(threadStation)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    // Копирайт Яндекс Расписаний
    func getCopyright() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let copyright = try await service.getCopyright()
                print ("\nКопирайт Яндекс Расписаний\n")
                print(copyright)
            } catch {
                print("Error: \(error)")
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
                print ("\nПолный список станций\n")
                print(allStations)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
