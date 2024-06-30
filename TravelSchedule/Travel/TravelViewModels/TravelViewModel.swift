//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import SwiftUI
import OpenAPIURLSession

final class TravelViewModel: ObservableObject {
    
    @ObservedObject var citiesViewModel: CitiesViewModel
    @ObservedObject var routesViewModel: RoutesViewModel
    @ObservedObject var storiesViewModel: StoriesViewModel
    
    @Published var findButtonIsHidden = true
    
    @Published var from = Constant.from {
        didSet {
            checkFindButtonVisibility()
        }
    }
    
    @Published var to = Constant.to  {
        didSet {
            checkFindButtonVisibility()
        }
    }
    
    init() {
        self.citiesViewModel = CitiesViewModel()
        self.routesViewModel = RoutesViewModel()
        self.storiesViewModel = StoriesViewModel(models: Constant.storiesData)
        getStationsList()
    }
    
    func swapFromTo () {
        swap(&from, &to)
    }
    
    private func checkFindButtonVisibility() {
        findButtonIsHidden = from == Constant.from || to == Constant.to || from == Constant.to || to == Constant.from
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
                
 //               let allCities = allStations.countries?.filter{$0.title == "Россия"}.map{$0.regions}.map{$0.map{$0.map{$0.settlements}}}.map{$0.map{$0.map{$0.map{$0.map{$0.title}}}}}
                
                let allRussia = allStations.countries?.filter{$0.title == "Россия"}
                
                let allRegions = allRussia.map{$0.map{$0.regions}}
                
                let allSettlements = allRegions.map{$0.map{$0.map{$0.map{$0.settlements}}}}
                
                let allCities = allSettlements.map{$0.compactMap{$0.map{$0.compactMap{$0.map{$0.compactMap{$0.title}}}}}}
                
                print (allCities)
                
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
