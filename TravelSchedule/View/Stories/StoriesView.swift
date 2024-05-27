//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let stories: [StoryModel]
    @State var currentStoryIndex: Int = .zero
    @State var oldStoryIndex: Int = .zero
    @State var currentProgress: CGFloat = .zero
    @State var viewInFinalState = false
    
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Color.blackUniv
                .ignoresSafeArea()
            
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: oldStoryIndex, newIndex: newValue)
                    oldStoryIndex = newValue
                }
            
            CloseButton(action: {
                dismiss()
            })
            .padding(.top, 50)
            .padding(.trailing, 12)
            
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.horizontal, 12)
            .padding(.top, 28)
            .onChange(of: currentProgress) { newValue in
                didChangeCurrentProgress(newProgress: newValue)
                if currentProgress >= 1 {
                    dismiss()
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onEnded { _ in
                    dismiss()
                }
        )
        .opacity(viewInFinalState ? 1 : 0)
        .scaleEffect(viewInFinalState ? 1 : 0)
        .animation(.easeInOut(duration: 0.5), value: viewInFinalState)
        .onAppear {
            viewInFinalState = true
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
