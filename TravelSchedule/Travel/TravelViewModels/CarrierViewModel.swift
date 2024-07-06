//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation

final class CarrierViewModel: ObservableObject {
    
    @Published var logo: String
    @Published var name: String
    @Published var email: String
    @Published var phone: String
    
    init(logo: String, name: String, email: String, phone: String) {
        self.logo = logo
        self.name = name
        self.email = email
        self.phone = phone
    }
}

