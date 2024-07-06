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
    
    @Published var from = Constant.from {
        didSet {
            checkFindButtonVisibility()
        }
    }
    
    @Published var to = Constant.to  {
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
        findButtonIsHidden = from == Constant.from || to == Constant.to || from == Constant.to || to == Constant.from
    }
}
