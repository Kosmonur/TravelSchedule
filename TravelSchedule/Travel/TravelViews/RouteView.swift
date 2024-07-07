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
                AsyncImage(url: URL(string: route.carrier.logo)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 38, height: 38)
                } placeholder: {}
                VStack(alignment: .leading) {
                    Text(route.carrier.name)
                        .lineLimit(1)
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
                    .lineLimit(1)
                    .font(.regular12)
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
        .background(.lightGr)
        .cornerRadius(24)
    }
}

#Preview {
    RouteView(route: RouteModel(transfer: "С пересадкой в Костроме",
                                date: "14 января",
                                startTime: "20:32",
                                endTime: "04:58",
                                duration: "32 ч 26 мин",
                                carrier: CarrierModel(logo: "",
                                                      name: "Северо-западная пригородная пассажирская компания",
                                                      email: "i.lozgkina@yandex.ru",
                                                      phone: "(812) 458-68-68")))
}
