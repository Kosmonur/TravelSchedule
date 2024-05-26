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
        model = (1...18).map { StoryModel(id: $0-1,
                                          imageName: "\($0)",
                                          title: "Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0)",
                                          description: "Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0) Text\($0)",
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

