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
    @State var isProgressViewVisible: Bool = true
    @StateObject var viewModel = WebView.ProgressViewModel(progress: .zero)
    
    var body: some View {
        ZStack {
            Color(.whiteApp)
                .ignoresSafeArea()
            VStack {
                if isConnected {
                    if isProgressViewVisible {
                        ProgressView(value: viewModel.progress)
                            .progressViewStyle(.linear)
                            .tint(.blackApp)
                            .scaleEffect(x: 1, y: 0.5)
                            .onChange(of: viewModel.progress) { value in
                                if value > 0.99 {
                                    isProgressViewVisible = false
                                }
                            }
                    }
                    WebView(url: Constant.agreementURL, viewModel: viewModel)
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
