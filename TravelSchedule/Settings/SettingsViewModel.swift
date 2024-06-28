//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isDarkModeOn = false
    
    func setScreenMode(darkMode: Bool) {
        isDarkModeOn = darkMode
    }
}

