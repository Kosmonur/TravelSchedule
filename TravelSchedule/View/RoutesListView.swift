//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import SwiftUI

struct RoutesListView: View {
    
    @StateObject var viewModel = ScheduleViewModel()
    @State var title: String
    
    var filteredRoutes: [RouteModel] {
        return(viewModel.routes)
    }
    
    var body: some View {
        ZStack {
            Color(.whiteApp)
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .font(.bold24)
                    .foregroundColor(.blackApp)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(filteredRoutes) { route in
                            NavigationLink(destination: EmptyView()) {
                                RouteView(route: route)
                            }
                        }
                    }
                }
                .padding(.bottom, -32)
                
                NavigationLink(destination: EmptyView()) {
                    Text(Constant.specifyTime)
                        .foregroundColor(.white)
                        .font(.bold17)
                        .frame(maxWidth: .infinity)
                        .frame( height: 60)
                        .background(.blueUniv)
                        .cornerRadius(16)
                }
            }
            .toolbarRole(.editor)
            .padding(16)
        }
    }
}

#Preview {
    RoutesListView(title: "Маршрут")
}
