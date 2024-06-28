//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import Foundation

final class TravelViewModel: ObservableObject {
    
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
    
    func swapFromTo () {
        swap(&from, &to)
    }
    
    private func checkFindButtonVisibility() {
        findButtonIsHidden = from == Constant.from || to == Constant.to || from == Constant.to || to == Constant.from
    }
}
