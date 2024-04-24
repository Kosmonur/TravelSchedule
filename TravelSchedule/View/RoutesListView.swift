//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import SwiftUI

struct RoutesListView: View {
    
    @ObservedObject private var viewModel = RoutesViewModel()
    @State var title: String
    @State var isRedDotHide = true
    @State var isMorningOn = true
    @State var isDayOn = true
    @State var isEveningOn = true
    @State var isNightOn = true
    @State var isTransfersOn = true
    
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
                            NavigationLink(destination: CarrierView(logo: route.logo)) {
                                RouteView(route: route)
                            }
                        }
                    }
                }
                .padding(.bottom, -32)
                
                NavigationLink(destination: FilterTimeView(isMorningOn: $isMorningOn, isDayOn: $isDayOn, isEveningOn: $isEveningOn, isNightOn: $isNightOn, isTransfersOn: $isTransfersOn)) {
                    HStack{
                        Text(Constant.specifyTime)
                        Rectangle()
                            .frame(width: 8, height: 8)
                            .cornerRadius(8)
                            .foregroundColor(.redUniv)
                            .opacity(isRedDotHide ? 0 : 1)
                    }
                    .foregroundColor(.white)
                    .font(.bold17)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blueUniv)
                    .cornerRadius(16)
                }
            }
            .toolbarRole(.editor)
            .padding(16)
        }
        .onAppear() {
            isRedDotHide = isMorningOn && isDayOn && isEveningOn && isNightOn && isTransfersOn
        }
    }
}

#Preview {
    RoutesListView(title: "Маршрут")
}
