//
//  StoriesModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import Foundation

final class StoriesModel: ObservableObject {
    
    @Published var models: [StoryPreviewModel]
    
    private let storyIdArray: [Int]
    
    init(models: [StoryPreviewModel] ) {
        self.models = models
        // массив с номерами всех StoryID от 0 до последнего, входящими в модель
        storyIdArray = models.flatMap{$0.storyModels.map{$0.id}}
    }
    
    // выставляет isViewed в сториз в true. Если все сториз, входящие в preview просмотрены, то preview .isViewed также выставляется в true
    func isViewed(currentStoryIndex: Int) {
        
        // массив, размером равный массиву StoryID, но вместо id Story стоит id preview, в который входит данная Story
        let previewId = models.map {model in
            (.zero ..< model.storyModels.count).map {_ in model.id}
        }
            .flatMap {$0}[currentStoryIndex]
        
        let viewedStory = models[previewId].storyModels.enumerated().map { id, storyModel in
            id == storyIdArray[currentStoryIndex] ? StoryModel(id: storyModel.id,
                                                               imageName: storyModel.imageName,
                                                               title: storyModel.title,
                                                               description: storyModel.description,
                                                               isViewed: true) : storyModel
        }
        
        models[previewId] = StoryPreviewModel(id: previewId,
                                              previewImageName: models[previewId].previewImageName,
                                              title: models[previewId].title,
                                              isViewed: !viewedStory.map{$0.isViewed}.contains(false),
                                              storyModels: viewedStory)
    }
    
    func allStoriesArray() -> [StoryModel] {
        // массив всех stories в порядке их расположения в preview
        models
            .flatMap{$0.storyModels}.enumerated()
            .map { StoryModel(id: $0,
                              imageName: $1.imageName,
                              title: $1.title,
                              description: $1.description,
                              isViewed: $1.isViewed)}
    }
    
    func storiesBeforePreview(previewIndex: Int) -> Int {
        //возвращает суммарное кол-во сториз во всех preview до previewIndex
        (.zero ... previewIndex).map {models[$0].storyModels.count }.reduce(.zero, +) - models[previewIndex].storyModels.count
    }
    
    func currentPreviewIndex(currentStoryIndex: Int) -> Int {
        //возвращает по индексу сториз в общем массиве индекс preview, в которую эта сториз входит
        models.map {model in
            (.zero ..< model.storyModels.count).map {_ in model.id}
        }.flatMap {$0}[currentStoryIndex]
    }
    
    func storiesInPreview(previewIndex: Int) -> Int {
        // возвращает кол-во сториз в preview по его индексу
        models[previewIndex].storyModels.count
    }
    
    func storyIndexInStories(index: Int) -> Int {
        // возвращает индекс сториз в preview по индексу в общем массиве
        storyIdArray[index]
    }
    
}
