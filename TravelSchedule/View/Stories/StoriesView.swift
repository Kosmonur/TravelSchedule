//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let previewIndex: Int
    
    private let stories: [StoryModel]
    @State var currentStoryIndex: Int
    @State var oldStoryIndex: Int = .zero
    @State var currentProgress: CGFloat = .zero
    @State var viewInFinalState = false
    
    init(storyPreviewModel: [StoryPreviewModel], previewIndex: Int) {
        self.previewIndex = previewIndex
        
        stories = storyPreviewModel
            .flatMap{$0.storyModels}.enumerated()
            .map { StoryModel(id: $0,
                              imageName: $1.imageName,
                              title: $1.title,
                              description: $1.description)}
        
        currentStoryIndex = (.zero ... previewIndex).map { storyPreviewModel[$0].storyModels.count }.reduce(.zero, +) - storyPreviewModel[previewIndex].storyModels.count
        
    }
    
    
    //    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    
    private let duration = 0.6
    
    private func closeStories() {
        viewInFinalState = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            dismiss()
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: oldStoryIndex, newIndex: newValue)
                    oldStoryIndex = newValue
                }
            
            CloseButton {
                closeStories()
            }
            .padding(.top, 50)
            .padding(.trailing, 12)
            
            //            StoriesProgressBar(
            //                storiesCount: stories.count,
            //                timerConfiguration: timerConfiguration,
            //                currentProgress: $currentProgress
            //            )
            //            .padding(.horizontal, 12)
            //            .padding(.top, 28)
            //            .onChange(of: currentProgress) { newValue in
            //                didChangeCurrentProgress(newProgress: newValue)
            //                if currentProgress >= 1 {
            //                    closeStories()
            //               }
            //            }
        }
        .gesture(
            DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onEnded { _ in
                    closeStories()
                }
        )
        .scaleEffect(viewInFinalState ? 1 : 0)
        .background(viewInFinalState ? .blackUniv : .clear)
        .animation(.easeInOut(duration: duration), value: viewInFinalState)
        .onAppear {
            viewInFinalState = true
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        //        let progress = timerConfiguration.progress(for: newIndex)
        //         guard abs(progress - currentProgress) >= 0.01 else { return }
        //         withAnimation {
        //             currentProgress = progress
        //        }
    }
    
    //    private func didChangeCurrentProgress(newProgress: CGFloat) {
    //        let index = timerConfiguration.index(for: newProgress)
    //        guard index != currentStoryIndex else { return }
    //        withAnimation {
    //            currentStoryIndex = index
    //        }
    //    }
}

#Preview {
    StoriesView(storyPreviewModel: StoryPreviewViewModel().models, previewIndex: 5)
}
