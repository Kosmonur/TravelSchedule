//
//  SearchCityView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import SwiftUI

struct SearchCityView: View {
    
    @ObservedObject var citiesViewModel: CitiesViewModel
    
    @Binding var path: NavigationPath
    @Binding var from: String
    @Binding var to: String
    let selectionType: SelectionType

    var body: some View {
        let searchCityResult = citiesViewModel.searchCityResult()
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack {
                SearchBar(searchText: $citiesViewModel.searchCity)
                List(searchCityResult) { city in
                    NavigationLink(destination: SearchStationView(path: $path, from: $from, to: $to, city: city, selectionType: selectionType)) {
                        Text(city.name)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .overlay(Group {
                    if searchCityResult.isEmpty {
                        Text(Constant.cityNotFound)
                            .foregroundStyle(.blackApp)
                            .font(.bold24)
                    }
                })
                .toolbarRole(.editor)
                .navigationTitle(Constant.citySelect)
            }
        }
    }
}

#Preview {
    SearchCityView(citiesViewModel: CitiesViewModel(),
                   path: .constant(NavigationPath()),
                   from: .constant(Constant.from),
                   to: .constant(Constant.to),
                   selectionType: .departure)
}
