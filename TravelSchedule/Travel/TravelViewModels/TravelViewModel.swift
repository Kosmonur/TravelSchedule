//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import SwiftUI

@MainActor
final class TravelViewModel: ObservableObject {
    
    @Published var findButtonIsHidden = true
    
    @Published var from = StationModel(name: Constant.from, code: "") {
        didSet {
            checkFindButtonVisibility()
        }
    }
    
    @Published var to = StationModel(name: Constant.to, code: "") {
        didSet {
            checkFindButtonVisibility()
        }
    }
    
    let citiesViewModel = CitiesViewModel()
    let storiesViewModel = StoriesViewModel(models: Constant.storiesData)
    
    func swapFromTo () {
        swap(&from, &to)
    }
    
    private func checkFindButtonVisibility() {
        findButtonIsHidden = from.name == Constant.from || to.name == Constant.to || from.name == Constant.to || to.name == Constant.from
    }
}
