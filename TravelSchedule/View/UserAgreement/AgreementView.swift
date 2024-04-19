//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI
import Network

struct AgreementView: View {
    
    @State private var isConnected = true
    
    var body: some View {
        if isConnected {
            WebView(url: Constant.agreementURL)
                .navigationTitle(Constant.userAgreement)
                .background(.whiteApp)
                .onAppear {
                    checkConnection()
                }
        } else {
            ErrorView(errorType: .noInternet)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    func checkConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}

#Preview {
    AgreementView()
}
