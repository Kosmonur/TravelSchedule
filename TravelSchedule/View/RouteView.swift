//
//  RouteView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import SwiftUI

struct RouteView: View {
    
    @State var route: RouteModel
    
    var body: some View {
        VStack(spacing: 14) {
            HStack(alignment: .top) {
                Image(uiImage: (UIImage(named: route.logo) ?? UIImage()))
                VStack(alignment: .leading) {
                    Text(route.carrierName)
                        .font(.regular17)
                        .foregroundStyle(.blackUniv)
                    Text(route.transfer)
                        .font(.regular12)
                        .foregroundStyle(.redUniv)
                }
                Spacer()
                Text(route.date)
                    .font(.regular12)
                    .foregroundStyle(.blackUniv)
            }
            HStack {
                Text(route.startTime)
                Rectangle()
                    .foregroundColor(.grayUniv)
                    .frame(height: 1)
                Text(route.duration)
                Rectangle()
                    .foregroundColor(.grayUniv)
                    .frame(height: 1)
                Text(route.endTime)
            }
            .font(.regular17)
            .foregroundStyle(.blackUniv)
        }
        .frame(height: 104)
        .padding(.horizontal, 14)
        .background(.lightGray)
        .cornerRadius(24)
    }
}

#Preview {
    RouteView(route: RoutesViewModel().routes[0])
}
