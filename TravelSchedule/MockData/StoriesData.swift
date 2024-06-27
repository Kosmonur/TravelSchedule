//
//  StoriesData.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 04.06.2024.
//

let storiesData = (1...9).map { StoryPreviewModel(id: $0-1,
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
