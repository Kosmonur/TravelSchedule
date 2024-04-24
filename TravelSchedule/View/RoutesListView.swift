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
    @State var isRedDotVisible: Bool = true
    
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
                
                NavigationLink(destination: EmptyView()) {
                    HStack{
                        Text(Constant.specifyTime)
                        Rectangle()
                            .frame(width: 8, height: 8)
                            .cornerRadius(8)
                            .foregroundColor(.redUniv)
                            .opacity(isRedDotVisible ? 1 : 0)
                    }
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
