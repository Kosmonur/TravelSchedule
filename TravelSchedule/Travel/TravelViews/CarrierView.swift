//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import SwiftUI

struct CarrierView: View {
    
    @ObservedObject private var carrierViewModel = CarrierViewModel()
    @State var logo: String
    
    var body: some View {
        
        let carrier = carrierViewModel.getCarrierWithLogo(logo: logo)
        
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack (spacing: 16) {
                Image(carrier.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(24)
                    .frame(height: 104)
                
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(carrier.name)
                            .font(.bold24)
                            .foregroundColor(.blackApp)
                        
                        VStack(alignment: .leading) {
                            Text(carrier.email == "" ? "" : Constant.email)
                                .font(.regular17)
                                .foregroundColor(.blackApp)
                            Text(carrier.email)
                                .font(.regular12)
                                .foregroundColor(.blueUniv)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(carrier.phone == "" ? "" : Constant.phone)
                                .font(.regular17)
                                .foregroundColor(.blackApp)
                            Text(carrier.phone)
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
    CarrierView(logo: "rzhd")
}
