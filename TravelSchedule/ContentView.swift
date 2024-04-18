//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .whiteApp
    }
    
    var body: some View {
        
        NavigationStack {
            TabView(selection: $selectedTab) {
                ScheduleView()
                    .tabItem {
                        Image(.schedule)
                            .renderingMode(.template)
                    }
                    .tag(0)
                SettingsView()
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
