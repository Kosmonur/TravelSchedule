//
//  Constant.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

enum Constant {
    
    static let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")!
    static let from = "Откуда"
    static let to = "Куда"
    static let userAgreement = "Пользовательское соглашение"
    static let blackTheme = "Тёмная тема"
    static let appAbout = "Приложение использует API «Яндекс.Расписания»"
    static let appVersion = "Версия 1.0 (beta)"
    static let noInternet = "Нет интернета"
    static let serverErr = "Ошибка сервера"
    static let searchPlaceholder = "Введите запрос"
    static let citySelect = "Выбор города"
    static let stationSelect = "Выбор станции"
    static let cityNotFound = "Город не найден"
    static let stationNotFound = "Станция не найдена"
    static let find = "Найти"
    static let specifyTime = "Уточнить время"
    static let email = "E-mail"
    static let phone = "Телефон"
    static let carrierInfo = "Информация о перевозчике"
    static let departureTime = "Время отправления"
    static let showTransfer = "Показывать варианты с пересадками"
    static let yes = "Да"
    static let no = "Нет"
    static let morningTime = "Утро 06:00 - 12:00"
    static let dayTime = "День 12:00 - 18:00"
    static let eveningTime = "Вечер 18:00 - 00:00"
    static let nightTime = "Ночь 00:00 - 06:00"
    static let apply = "Применить"
    static let noOptions = "Вариантов нет"
    
    //MockData
    
    static let storiesData = (1...9).map { StoryPreviewModel(id: $0-1,
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
