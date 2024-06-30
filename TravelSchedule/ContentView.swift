//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var path = NavigationPath()
    @State private var selectedTab: Int = .zero
    
    private let settingsViewModel = SettingsViewModel()
    private let travelViewModel = TravelViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedTab) {
                TravelView(travelViewModel: travelViewModel,
                           path: $path)
                    .tabItem {
                        Image(.schedule)
                            .renderingMode(.template)
                    }
                    .tag(0)
                SettingsView(viewModel: settingsViewModel)
                    .tabItem {
                        Image(.setup)
                            .renderingMode(.template)
                    }
                    .tag(1)
            }
        }
        .tint(.blackApp)
    }
}

#Preview {
    ContentView()
}
