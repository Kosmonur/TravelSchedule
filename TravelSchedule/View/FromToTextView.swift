//
//  FromToTextView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 22.04.2024.
//

import SwiftUI

struct FromToTextView: View {
    
    var type: String
    
    var body: some View {
        Text(type)
            .font(.regular17)
            .scaledToFit()
            .minimumScaleFactor(0.5)
            .foregroundStyle(type == Constant.from || type == Constant.to ? .grayUniv: .blackUniv)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding(.horizontal)
    }
}

#Preview {
    FromToTextView(type: Constant.from)
}
