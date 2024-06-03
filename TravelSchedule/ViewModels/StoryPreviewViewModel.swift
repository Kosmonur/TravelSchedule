//
//  StoryPreviewViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import Foundation

final class StoryPreviewViewModel: ObservableObject {
    
    @Published var models: [StoryPreviewModel]
    
    init() {
        models = (1...9).map { StoryPreviewModel(id: $0-1,
                                                 previewImageName: "Preview\($0)",
                                                 title: String(repeating: "Text\($0-1) ", count: 10),
                                                 isViewed: false,
                                                 storyModels: [StoryModel(id: 0,
                                                                          imageName: "\(2*$0-1)",
                                                                          title: String(repeating: "Text\(2*$0-2) ", count: 10),
                                                                          description: String(repeating: "Text\(2*$0-2) ", count: 20),
                                                                          isViewed: false),
                                                               StoryModel(id: 1,
                                                                          imageName: "\(2*$0)",
                                                                          title: String(repeating: "Text\(2*$0-1) ", count: 10),
                                                                          description: String(repeating: "Text\(2*$0-1) ", count: 20),
                                                                          isViewed: false)
                                                 ])}
    }
    
    func isViewed(previewId: Int, storyId: Int) {
        // выставляет isViewed в сториз в true. Если все сториз, входящие в preview просмотрены, то preview .isViewed также выставляется в true
        let viewedStory = models[previewId].storyModels.enumerated().map { id, storyModel in
            id == storyId ? StoryModel(id: storyModel.id,
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
    
    func allStoriesIdArray() -> [Int] {
        // массив с номерами всех StoryID от 0 до последнего, входящими в модель
        models.flatMap{$0.storyModels.map{$0.id}}
    }
    
    func allPreviewIdArray() -> [Int] {
        // массив, размером равный массиву StoryID, но вместо id Story стоит id preview, в который входит данная Story
        models.map {model in
            (.zero ..< model.storyModels.count).map {_ in model.id}
        }
        .flatMap {$0}
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
    
}
