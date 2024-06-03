//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let storyPreviewViewModel: StoryPreviewViewModel
    
    private let duration = 0.6
    private let stories: [StoryModel]
    private let storyIdArray: [Int]
    private let previewIdArray: [Int]
    
    @State private var viewInFinalState = false
    @State private var currentStoryIndex: Int
    @State private var currentPreviewIndex: Int
    @State private var oldPreviewIndex: Int
    @State private var storiesBeforePreview: Int
    @State private var storiesInCurrentPreview: Int
    @State private var currentProgress: CGFloat = .zero
    @State private var timerConfiguration: TimerConfiguration
    
    init(storyPreviewModel: StoryPreviewViewModel, previewIndex: Int) {
        self.storyPreviewViewModel = storyPreviewModel
        
        stories = storyPreviewModel.allStoriesArray()
        storyIdArray = storyPreviewModel.allStoriesIdArray()
        previewIdArray = storyPreviewModel.allPreviewIdArray()
        
        currentPreviewIndex = previewIndex
        oldPreviewIndex = previewIndex
        
        currentStoryIndex = storyPreviewModel.storiesBeforePreview(previewIndex: previewIndex)
        
        storiesBeforePreview = storyPreviewModel.storiesBeforePreview(previewIndex: previewIndex)
        
        storiesInCurrentPreview = storyPreviewModel.storiesInPreview(previewIndex: previewIndex)
        
        
        timerConfiguration = TimerConfiguration(storiesCount: storyPreviewModel.storiesInPreview(previewIndex: previewIndex))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { _ in
                    didChangeCurrentIndex()
                }
                .onAppear(){
                    storyPreviewViewModel.isViewed(previewId: previewIdArray[currentStoryIndex], storyId: storyIdArray[currentStoryIndex])
                }
                .animation(.easeInOut(duration: duration), value: currentStoryIndex)
            
            CloseButton {
                closeStories()
            }
            .padding(.top, 50)
            .padding(.trailing, 12)
            
            StoriesProgressBar(
                storiesCount: storiesInCurrentPreview,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.horizontal, 12)
            .padding(.top, 28)
            .onChange(of: currentProgress) { newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onEnded { _ in
                    closeStories()
                }
        )
        .scaleEffect(viewInFinalState ? 1 : .zero)
        .background(viewInFinalState ? .blackUniv : .clear)
        .animation(.easeInOut(duration: duration), value: viewInFinalState)
        .onAppear {
            viewInFinalState = true
        }
    }
    
    private func didChangeCurrentIndex() {
        
        storyPreviewViewModel.isViewed(previewId: previewIdArray[currentStoryIndex], storyId: storyIdArray[currentStoryIndex])
        
        changeIndexes()
        
        if currentPreviewIndex > oldPreviewIndex {
            currentProgress = .zero
        } else {
            currentProgress = timerConfiguration.progress(for: storyIdArray[currentStoryIndex])
        }
        
        oldPreviewIndex = currentPreviewIndex
        
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        
        if currentProgress >= 1 {
            
            guard currentStoryIndex + 1 < stories.count else { closeStories()
                return }
            
            currentStoryIndex += 1
            changeIndexes()
            currentProgress = .zero
            
        } else {
            
            let index = storiesBeforePreview + timerConfiguration.index(for: newProgress)
            guard index != currentStoryIndex else { return }
            withAnimation {
                currentStoryIndex = index
            }
        }
    }
    
    private func closeStories() {
        viewInFinalState = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            dismiss()
        }
    }
    
    private func changeIndexes() {
        currentPreviewIndex = storyPreviewViewModel.currentPreviewIndex(currentStoryIndex: currentStoryIndex)
        
        storiesBeforePreview = storyPreviewViewModel.storiesBeforePreview(previewIndex: currentPreviewIndex)
        
        storiesInCurrentPreview = storyPreviewViewModel.storiesInPreview(previewIndex: currentPreviewIndex)
        
        timerConfiguration.storiesCount =  storiesInCurrentPreview
    }
}

#Preview {
    StoriesView(storyPreviewModel: StoryPreviewViewModel(), previewIndex: 5)
}
