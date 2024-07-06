//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import SwiftUI

final class TravelViewModel: ObservableObject {
    
    @ObservedObject var citiesViewModel: CitiesViewModel
    @ObservedObject var storiesViewModel: StoriesViewModel
    
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
    
    init() {
        self.citiesViewModel = CitiesViewModel()
        self.storiesViewModel = StoriesViewModel(models: Constant.storiesData)
        citiesViewModel.getStationsList()
    }
    
    func swapFromTo () {
        swap(&from, &to)
    }
    
    private func checkFindButtonVisibility() {
        findButtonIsHidden = from.name == Constant.from || to.name == Constant.to || from.name == Constant.to || to.name == Constant.from
    }
}
