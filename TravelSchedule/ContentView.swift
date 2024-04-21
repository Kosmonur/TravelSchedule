//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var path = NavigationPath()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedTab) {
                ScheduleView(path: $path)
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
