//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoriesView: View {
    
    let stories: [StoryModel]
    @State var currentStoryIndex: Int = .zero
    @State var oldStoryIndex: Int = .zero
    @State var currentProgress: CGFloat = .zero
    
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: oldStoryIndex, newIndex: newValue)
                    oldStoryIndex = newValue
                }
            
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.horizontal, 12)
            .onChange(of: currentProgress) { newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
            
            CloseButton(action: {})
                .padding(.top, 50)
                .padding(.trailing, 12)
            
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

#Preview {
    StoriesView(stories: StoryViewModel().model.filter {(0...3).contains($0.id)})
}
