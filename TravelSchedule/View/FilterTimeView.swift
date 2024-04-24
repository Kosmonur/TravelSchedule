//
//  FilterTimeView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import SwiftUI

struct FilterTimeView: View {
    
    @Binding var isMorningOn: Bool
    @Binding var isDayOn: Bool
    @Binding var isEveningOn: Bool
    @Binding var isNightOn: Bool
    @Binding var isTransfersOn: Bool
    
    var body: some View {
        ZStack {
            Color(.whiteApp)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Section {
                    CheckBoxView(isOn: $isMorningOn, label: Constant.morningTime)
                    CheckBoxView(isOn: $isDayOn, label: Constant.dayTime)
                    CheckBoxView(isOn: $isEveningOn, label: Constant.eveningTime)
                    CheckBoxView(isOn: $isNightOn, label: Constant.nightTime)
                } header: {
                    Text(Constant.departureTime)
                        .font(.bold24)
                        .foregroundColor(.blackApp)
                }
                Section {
                    RadioButtonView(isOn: $isTransfersOn, label: Constant.yes)
                    RadioButtonView(isOn: !$isTransfersOn, label: Constant.no)
                } header: {
                    Text(Constant.showTransfer)
                        .font(.bold24)
                        .foregroundColor(.blackApp)
                }
                Spacer()
            }
            .padding(16)
        }
        .toolbarRole(.editor)
    }
}

prefix func !(value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

#Preview {
    FilterTimeView(isMorningOn: .constant(true), isDayOn: .constant(true), isEveningOn: .constant(true), isNightOn: .constant(true), isTransfersOn: .constant(true))
}
