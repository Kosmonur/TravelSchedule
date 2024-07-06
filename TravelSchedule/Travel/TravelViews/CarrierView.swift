//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import SwiftUI

struct CarrierView: View {
    
    @ObservedObject var carrierViewModel: CarrierViewModel
    
    init(carrier: CarrierModel) {
        carrierViewModel = CarrierViewModel(logo: carrier.logo,
                                            name: carrier.name,
                                            email: carrier.email,
                                            phone: carrier.phone)
    }
    
    var body: some View {
        
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack (spacing: 16) {
                AsyncImage(url: URL(string: carrierViewModel.logo)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 104)
                        .clipped()
                } placeholder: {}
                .padding(.horizontal, 32)
                
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
                .toolbarRole(.editor)
                .navigationTitle(Constant.carrierInfo)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    CarrierView(carrier: CarrierModel(logo: "https://yastat.net/s3/rasp/media/data/company/logo/szppk_logo2.png", name: "Северо-западная пригородная пассажирская компания", email: "i.lozgkina@yandex.ru", phone: "(812) 458-68-68") )
}
