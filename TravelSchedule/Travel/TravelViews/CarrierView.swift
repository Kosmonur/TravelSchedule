//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import SwiftUI

struct CarrierView: View {
    
    @ObservedObject var carrierViewModel: CarrierViewModel
    
    var body: some View {
        
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack (spacing: 16) {
                AsyncImage(url: URL(string: carrierViewModel.logo))
//                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(24)
                    .frame(height: 104)
                
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(carrierViewModel.name)
                            .font(.bold24)
                            .foregroundColor(.blackApp)
                        
                        VStack(alignment: .leading) {
                            Text(carrierViewModel.email == "" ? "" : Constant.email)
                                .font(.regular17)
                                .foregroundColor(.blackApp)
                            Text(carrierViewModel.email)
                                .font(.regular12)
                                .foregroundColor(.blueUniv)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(carrierViewModel.phone == "" ? "" : Constant.phone)
                                .font(.regular17)
                                .foregroundColor(.blackApp)
                            Text(carrierViewModel.phone)
                                .font(.regular12)
                                .foregroundColor(.blueUniv)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .toolbarRole(.editor)
                .navigationTitle(Constant.carrierInfo)
            }
        }
    }
}

#Preview {
    CarrierView(carrierViewModel: CarrierViewModel(logo: "https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png", name: "Северо-западная пригородная пассажирская компания", email: "i.lozgkina@yandex.ru", phone: "(812) 458-68-68") )
}
