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
        
        TabView(selection: $selectedTab) {
            
            ScheduleView()
                .tabItem {
                    Image(.schedule)
                        .renderingMode(.template)
                }
                .border(.gray)
                .padding(.leading, -1)
                .padding(.trailing, -1)
                .padding(.top, -1)
                .edgesIgnoringSafeArea(.top)
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(.setup)
                        .renderingMode(.template)
                }
                .border(.gray)
                .padding(.leading, -1)
                .padding(.trailing, -1)
                .padding(.top, -1)
                .edgesIgnoringSafeArea(.top)
                .tag(1)
        }
        .tint(.blackApp)
    }
}

#Preview {
    ContentView()
}
