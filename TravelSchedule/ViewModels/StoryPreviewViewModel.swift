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
                                                 title: "Text Text Text Text Text Text Text Text",
                                                 isViewed: false,
                                                 storyModels: [StoryModel(id: 0,
                                                                          imageName: "\(2*$0-1)",
                                                                          title: "Text \(2*$0-2)",
                                                                          description: "Text \(2*$0-2)",
                                                                          isViewed: false),
                                                               StoryModel(id: 1,
                                                                          imageName: "\(2*$0)",
                                                                          title: "Text \(2*$0-1)",
                                                                          description: "Text \(2*$0-1)",
                                                                          isViewed: false)
                                                 ])
        }
        models.append(StoryPreviewModel(id: 9,
                                        previewImageName: "Preview1",
                                        title: "Text Text Text Text Text Text Text Text",
                                        isViewed: false,
                                        storyModels: [StoryModel(id: 0,
                                                                 imageName: "1",
                                                                 title: "Text18",
                                                                 description: "Text18",
                                                                 isViewed: false),
                                                      StoryModel(id: 1,
                                                                 imageName: "2",
                                                                 title: "Text19",
                                                                 description: "Text19",
                                                                 isViewed: false),
                                                      StoryModel(id: 2,
                                                                 imageName: "3",
                                                                 title: "Text20",
                                                                 description: "Text20",
                                                                 isViewed: false)
                                        ]))
        models.append(StoryPreviewModel(id: 10,
                                        previewImageName: "Preview5",
                                        title: "Text Text Text Text Text Text Text Text",
                                        isViewed: false,
                                        storyModels: [StoryModel(id: 0,
                                                                 imageName: "9",
                                                                 title: "Text21",
                                                                 description: "Text21",
                                                                 isViewed: false)]))
    }
    
    func isViewed(previewId: Int, storyId: Int) {
        
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
    
}


