//
//  StoryPreviewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import Foundation

struct StoryPreviewModel: Identifiable {
    let id: Int
    let previewImageName: String
    let title: String
    let isViewed: Bool
    let storyModels: [StoryModel]
}
