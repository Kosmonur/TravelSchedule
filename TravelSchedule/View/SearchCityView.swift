//
//  SearchCityView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import SwiftUI

struct SearchCityView: View {
    
    @Binding var path: NavigationPath
    let selectionType: SelectionType
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var searchCity: String = ""
    
    var searchCityResult: [CityModel] {
        if searchCity.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { $0.name.lowercased().contains(searchCity.lowercased()) }
        }
    }
    
    var body: some View {
        SearchBar(searchText: $searchCity)
        List(searchCityResult) { city in
            NavigationLink(destination: SearchStationView(path: $path, city: city, selectionType: selectionType, viewModel: viewModel)) {
                Text(city.name)
            }
        }
    }
}


#Preview {
    SearchCityView(path: ContentView().$path, selectionType: .departure, viewModel: ScheduleViewModel())
}
