//
//  RadioButtonView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import SwiftUI

struct RadioButtonView: View {
    
    @Binding var isOn: Bool
    @State var label: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
                .font(.regular17)
                .foregroundColor(.blackApp)
        }
        .frame(height: 60)
        .toggleStyle(ToggleRadioButtonStyle())
    }
}

struct ToggleRadioButtonStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "smallcircle.filled.circle" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .tint(.blackApp)
            }
        }
    }
}

#Preview {
    struct RadioButtonPreview: View {
        @State var isOn = true
        var body: some View {
            RadioButtonView(isOn: $isOn, label: Constant.no)
        }
    }
    return RadioButtonPreview()
}
