//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            ScheduleView()
            .tabItem {
                Image(selectedTab == 0 ? .schActive : .schNoActive)
            }
            .border(.gray)
            .padding(-1)
            .edgesIgnoringSafeArea(.top)
            .tag(0)
            
            SettingsView()
            .tabItem {
                Image(selectedTab == 1 ? .setActive : .setNoActive)
            }
            .border(.gray)
            .padding(-1)
            .edgesIgnoringSafeArea(.top)
            .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
