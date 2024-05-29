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
                                                                          description: "Text \(2*$0-2)"),
                                                               StoryModel(id: 1,
                                                                          imageName: "\(2*$0)",
                                                                          title: "Text \(2*$0-1)",
                                                                          description: "Text \(2*$0-1)")
                                                               
                                                 ])
        }
        models.append(StoryPreviewModel(id: 9,
                                        previewImageName: "Preview1",
                                        title: "Text Text Text Text Text Text Text Text",
                                        isViewed: false,
                                        storyModels: [StoryModel(id: 0,
                                                                 imageName: "1",
                                                                 title: "Text18",
                                                                 description: "Text18"),
                                                      StoryModel(id: 1,
                                                                 imageName: "2",
                                                                 title: "Text19",
                                                                 description: "Text19"),
                                                      StoryModel(id: 3,
                                                                 imageName: "3",
                                                                 title: "Text20",
                                                                 description: "Text20")
                                                      
                                        ]))
        models.append(StoryPreviewModel(id: 10,
                                        previewImageName: "Preview5",
                                        title: "Text Text Text Text Text Text Text Text",
                                        isViewed: false,
                                        storyModels: [StoryModel(id: 0,
                                                                 imageName: "9",
                                                                 title: "Text21",
                                                                 description: "Text21")]))
    }
    
        func isViewed(_ id: Int) {
            models[id] = StoryPreviewModel(id: id,
                                                previewImageName: models[id].previewImageName,
                                                title: models[id].title,
                                                isViewed: true,
                                                storyModels: models[id].storyModels)
            }
        }


