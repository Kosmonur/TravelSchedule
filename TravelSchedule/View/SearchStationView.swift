//
//  SearchStationView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import SwiftUI

struct SearchStationView: View {
    
    @Binding var path: NavigationPath
    
    let city: CityModel
    let selectionType: SelectionType
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var searchStation: String = ""
    
    var searchStationResult: [String] {
        if searchStation.isEmpty {
            return city.stations
        } else {
            return city.stations.filter { $0.lowercased().contains(searchStation.lowercased()) }
        }
    }
    
    var body: some View {
        SearchBar(searchText: $searchStation)
        List(searchStationResult, id: \.self) { station in
            NavigationLink(value: "") {
                Text(station)
            }
            .onTapGesture {
                switch selectionType {
                case .departure:
                    viewModel.fromCity = city.name
                    viewModel.fromStation = station
                case .arrival:
                    viewModel.toCity = city.name
                    viewModel.toStation = station
                }
                path = NavigationPath()
            }
        }
    }
}

#Preview {
    SearchStationView(path: ContentView().$path,
                      city: CityModel( name: "Сочи",
                                       stations: [ "Морской вокзал",
                                                   "Центральный вокзал",
                                                   "Южный вокзал"]),
                      selectionType: .departure,
                      viewModel: ScheduleViewModel())
}