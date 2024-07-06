//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import SwiftUI

struct RoutesListView: View {
    
    @ObservedObject var routesViewModel: RoutesViewModel
    @State var title: String
    
    var body: some View {
        let filteredRoutes = routesViewModel.filteredRoutes()
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .font(.bold24)
                    .foregroundColor(.blackApp)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(filteredRoutes) { route in
                            NavigationLink(destination: CarrierView(carrier: route.carrier)) {
                                RouteView(route: route)
                            }
                        }
                    }
                }
                .padding(.bottom, -32)
                NavigationLink(destination:
                                FilterTimeView(isMorningOn: $routesViewModel.isMorningOn, isDayOn: $routesViewModel.isDayOn, isEveningOn: $routesViewModel.isEveningOn, isNightOn: $routesViewModel.isNightOn, isTransfersOn: $routesViewModel.isTransfersOn)) {
                    HStack{
                        Text(Constant.specifyTime)
                        Rectangle()
                            .frame(width: 8, height: 8)
                            .cornerRadius(8)
                            .foregroundColor(.redUniv)
                            .opacity(routesViewModel.isRedDotHide ? .zero : 1)
                    }
                    .foregroundColor(.white)
                    .font(.bold17)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blueUniv)
                    .cornerRadius(16)
                    .onAppear {
                        routesViewModel.setRedDotStatus()
                    }
                }
            }
            .overlay(Group {
                if filteredRoutes.isEmpty {
                    HStack {
                        Spacer()
                        Text(Constant.noOptions)
                            .foregroundStyle(.blackApp)
                            .font(.bold24)
                        Spacer()
                    }
                }
            })
            .toolbarRole(.editor)
            .padding(16)
        }
    }
}

#Preview {
    RoutesListView(routesViewModel: RoutesViewModel(), title: "Маршрут")
}
