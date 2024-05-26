//
//  StoryModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 26.05.2024.
//

import Foundation

struct StoryModel: Identifiable {
    let id: UUID
    let imageName: String
    let title: String
    let description: String
    let isViewed: Bool
}
