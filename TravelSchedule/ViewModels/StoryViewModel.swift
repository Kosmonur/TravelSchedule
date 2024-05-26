//
//  StoryViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import Foundation

final class StoryViewModel: ObservableObject {
    
    @Published var model: [StoryModel]
    
    init() {
        model = (1...18).map { StoryModel(id: UUID(),
                                          imageName: "\($0)",
                                          title: "Text Text TextText Text Text Text Text Text",
                                          description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text TextText Text Text Text Text Text",
                                          isViewed: false)
        }
    }
    
//    func isViewed(_ id: UUID) {
//        model = model.map {
//            $0.id == id ? StoryModel(id: $0.id,
//                                     imageName: $0.imageName,
//                                     title: $0.title,
//                                     description: $0.description,
//                                     isViewed: true) : $0
//        }
//    }
}

