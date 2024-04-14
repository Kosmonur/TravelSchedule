//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: AgreementView()) {
                Text(Constant.userAgreement)
                    .font(.regular17)
            }
        }
        .tint(.blackApp)
    }
    
}

#Preview {
    SettingsView()
}
