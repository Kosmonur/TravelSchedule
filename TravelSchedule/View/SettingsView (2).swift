//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkModeOn = false
    @State private var isConnect = true
    
    var body: some View {
        VStack {
            List {
                Toggle(isOn: $isDarkModeOn) {
                    Text(Constant.blackTheme)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blueUniv))
                .padding(.top, 24)
                .listRowBackground(Color.clear)
                .onChange(of: isDarkModeOn) { isDarkModeOn in
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        for window in windowScene.windows {
                            window.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
                        }
                    }
                }
                NavigationLink(destination: {
                    if isConnect {
                        AgreementView()
                    }
                    else {
                        ErrorView(errorType: .noInternet)
                    }
                })
                {
                    Text(Constant.userAgreement)
                        .font(.regular17)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .navigationTitle(Constant.userAgreement)
            }
            .listStyle(.plain)
            .scrollDisabled(true)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                Text(Constant.appAbout)
                Text(Constant.appVersion)
            }
            .font(.regular12)
            .foregroundStyle(.blackApp)
            .padding(.bottom, 24)
            
            Rectangle().frame(height: 1)
                .foregroundStyle(.grayUniv)
                .padding(.bottom,10)
        }
        .background(.whiteApp)
        .onAppear(perform: {
            isDarkModeOn = colorScheme == .dark ? true : false})
    }
}

#Preview {
    SettingsView()
}
