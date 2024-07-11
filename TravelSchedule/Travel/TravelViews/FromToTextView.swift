//
//  FromToTextView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 22.04.2024.
//

import SwiftUI

struct FromToTextView: View {
    
    @Binding var type: StationModel
    
    var body: some View {
        Text(type.name)
            .font(.regular17)
            .foregroundStyle(type.name == Constant.from || type.name == Constant.to ? .grayUniv: .blackUniv)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

#Preview {
    FromToTextView(type: .constant(StationModel(name: Constant.from, code: "")))
}
