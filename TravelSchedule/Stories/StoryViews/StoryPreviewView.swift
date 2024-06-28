//
//  StoryPreviewView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoryPreviewView: View {
    
    var model: StoryPreviewModel
    
    var body: some View {
        ZStack{
            Image(model.previewImageName)
                .resizable()
                .scaledToFill()
                .opacity(model.isViewed ? 0.5 : 1)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(.blueUniv, lineWidth: model.isViewed ? 0 : 4))
            HStack {
                Text (model.title)
                    .font(.regular12)
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .padding(.init(top: 83, leading: 8, bottom: 12, trailing: 8))
                Spacer()
            }
        }
        .frame(width: 92, height: 140)
    }
}

#Preview {
    StoryPreviewView(model: StoryPreviewModel(id: 0, previewImageName: "Preview2", title: "Text ", isViewed: false, storyModels: []))
}

