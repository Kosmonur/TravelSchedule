//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoryView: View {
    
    let viewModel = StoryViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(viewModel.model[0].imageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .scaledToFill()
            
            VStack (spacing: 16) {
                Spacer()
                HStack {
                    Text (viewModel.model[0].title)
                        .font(.bold34)
                        .lineLimit(2)
                    Spacer()
                }
                HStack {
                    Text (viewModel.model[0].description)
                        .font(.regular20)
                        .lineLimit(3)
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .padding(.init(top: .zero, leading: 16, bottom: 40, trailing: 16))
        }
    }
}

#Preview {
    StoryView()
}
