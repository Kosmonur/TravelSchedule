//
//  SearchStationView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import SwiftUI

struct SearchStationView: View {
    
    @Binding var path: NavigationPath
    @Binding var from: StationModel
    @Binding var to: StationModel
    
    let city: CityModel
    let selectionType: SelectionType
    @State private var searchStation = ""
    
    var searchStationResult: [StationModel] {
        if searchStation.isEmpty {
            return city.stations.map{$0}
        } else {
            return city.stations.map{$0}.filter { $0.name.lowercased().contains(searchStation.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack {
                SearchBar(searchText: $searchStation)
                List(searchStationResult, id: \.self) { station in
                    NavigationLink(value: "") {
                        Text(station.name)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        switch selectionType {
                        case .departure:
                            from = StationModel(name: "\(city.name) (\(station.name))", code: station.code)
                        case .arrival:
                            to = StationModel(name: "\(city.name) (\(station.name))", code: station.code)
                        case .find: ()
                        }
                        path = NavigationPath()
                    }
                }
                .listStyle(.plain)
                .overlay(Group {
                    if searchStationResult.isEmpty {
                        Text(Constant.stationNotFound)
                            .foregroundStyle(.blackApp)
                            .font(.bold24)
                    }
                })
                .toolbarRole(.editor)
                .navigationTitle(Constant.stationSelect)
            }
        }
    }
}

#Preview {
    SearchCityView(citiesViewModel: CitiesViewModel(), path: .constant(NavigationPath()), from: .constant(StationModel(name: Constant.from, code: "")), to: .constant(StationModel(name: Constant.to, code: "")), selectionType: .departure)
}
