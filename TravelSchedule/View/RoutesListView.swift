//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import SwiftUI

struct RoutesListView: View {
    
    @State var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack(spacing: 8){
            RouteView(route: viewModel.routes[0])
            RouteView(route: viewModel.routes[1])
        }
        .toolbarRole(.editor)
        .padding(16)
        .navigationTitle("Name")
    }
}

#Preview {
    RoutesListView()
}
