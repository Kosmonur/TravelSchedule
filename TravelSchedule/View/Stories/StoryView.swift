//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoryView: View {
    
    let story: StoryModel
    
    var body: some View {
        ZStack {
            Image(story.imageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .scaledToFill()
            
            VStack (spacing: 16) {
                Spacer()
                HStack {
                    Text (story.title)
                        .font(.bold34)
                        .lineLimit(2)
                    Spacer()
                }
                HStack {
                    Text (story.description)
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
    StoryView(story: StoryModel(id: 0, imageName: "1", title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text", description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text", isViewed: false))
}
