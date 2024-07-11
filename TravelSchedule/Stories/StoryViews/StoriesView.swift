//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import SwiftUI

struct StoriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let storiesModel: StoriesViewModel
    
    private let duration = 0.6
    private let stories: [StoryModel]
    
    @State private var viewInFinalState = false
    @State private var currentStoryIndex: Int
    @State private var currentPreviewIndex: Int
    @State private var oldPreviewIndex: Int
    @State private var storiesBeforePreview: Int
    @State private var storiesInCurrentPreview: Int
    @State private var currentProgress: CGFloat = .zero
    @State private var timerConfiguration: TimerConfiguration
    
    init(storiesModel: StoriesViewModel) {
        self.storiesModel = storiesModel
        
        stories = storiesModel.allStoriesArray()
        
        currentPreviewIndex = storiesModel.previewIndex
        oldPreviewIndex = storiesModel.previewIndex
        
        currentStoryIndex = storiesModel.storiesBeforePreview(previewIndex: storiesModel.previewIndex)
        
        storiesBeforePreview = storiesModel.storiesBeforePreview(previewIndex: storiesModel.previewIndex)
        
        storiesInCurrentPreview = storiesModel.storiesInPreview(previewIndex: storiesModel.previewIndex)
        
        
        timerConfiguration = TimerConfiguration(storiesCount: storiesModel.storiesInPreview(previewIndex: storiesModel.previewIndex))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { _ in
                    didChangeCurrentIndex()
                }
                .onAppear(){
                    storiesModel.isViewed(currentStoryIndex: currentStoryIndex)
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
        
        storiesModel.isViewed(currentStoryIndex: currentStoryIndex)
        
        changeIndexes()
        
        if currentPreviewIndex > oldPreviewIndex {
            currentProgress = .zero
        } else {
            currentProgress = timerConfiguration.progress(for: storiesModel.storyIndexInStories(index: currentStoryIndex))
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
        currentPreviewIndex = storiesModel.currentPreviewIndex(currentStoryIndex: currentStoryIndex)
        
        storiesBeforePreview = storiesModel.storiesBeforePreview(previewIndex: currentPreviewIndex)
        
        storiesInCurrentPreview = storiesModel.storiesInPreview(previewIndex: currentPreviewIndex)
        
        timerConfiguration.storiesCount =  storiesInCurrentPreview
    }
}

#Preview {
    StoriesView(storiesModel: StoriesViewModel(models: Constant.storiesData))
}
