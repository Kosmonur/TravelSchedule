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
                                                                          title: "Text \(2*$0-1)",
                                                                          description: "Text \(2*$0-1)",
                                                                          isViewed: false),
                                                               StoryModel(id: 1,
                                                                          imageName: "\(2*$0)",
                                                                          title: "Text \(2*$0)",
                                                                          description: "Text \(2*$0)",
                                                                          isViewed: false)
                                                 ])
        }
    }
    
    
    //    func isViewed(_ id: UUID) {
    //        models = models.map {
    //            $0.id == id ? StoryPreviewModel(id: $0.id,
    //                                            previewImageName: $0.previewImageName,
    //                                            title: $0.title,
    //                                            isViewed: true,
    //                                            storyModelID: $0.storyModelID) : $0
    //        }
    //    }
}
