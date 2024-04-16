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
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $isDarkModeOn) {
                        Text(Constant.blackTheme)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blueUniv))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onChange(of: isDarkModeOn) { isDarkModeOn in
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            for window in windowScene.windows {
                                window.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
                            }
                        }
                    }
                    
                    NavigationLink(destination: AgreementView()) {
                        Text(Constant.userAgreement)
                            .font(.regular17)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
                .scrollDisabled(true)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Text(Constant.appAbout)
                    Text(Constant.appVersion)
                }
                .font(.regular12)
                .foregroundStyle(.blackApp)
            }
            .padding(.vertical, 24)
        }
        .tint(.blackApp)
        .onAppear(perform: {
            isDarkModeOn = colorScheme == .dark ? true : false
        })
    }
}

#Preview {
    SettingsView()
}
