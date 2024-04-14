//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

struct AgreementView: View {
    
    var body: some View {
        WebView(url: Constant.agreementURL)
            .navigationBarTitle(Constant.userAgreement, displayMode: .inline)
            .ignoresSafeArea()
    }
}

#Preview {
    AgreementView()
}
