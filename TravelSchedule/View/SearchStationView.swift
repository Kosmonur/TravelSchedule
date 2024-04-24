//
//  SearchStationView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import SwiftUI

struct SearchStationView: View {
    
    @Binding var path: NavigationPath
    @Binding var from: String
    @Binding var to: String
    let city: CityModel
    let selectionType: SelectionType
    @State private var searchStation: String = ""
    
    var searchStationResult: [String] {
        if searchStation.isEmpty {
            return city.stations
        } else {
            return city.stations.filter { $0.lowercased().contains(searchStation.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.whiteApp)
                .ignoresSafeArea()
            VStack {
                SearchBar(searchText: $searchStation)
                List(searchStationResult, id: \.self) { station in
                    NavigationLink(value: "") {
                        Text(station)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        switch selectionType {
                        case .departure:
                            from = "\(city.name) (\(station))"
                        case .arrival:
                            to = "\(city.name) (\(station))"
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
    SearchCityView(path: .constant(NavigationPath()), from: .constant(Constant.from), to: .constant(Constant.to), selectionType: .departure)
}
