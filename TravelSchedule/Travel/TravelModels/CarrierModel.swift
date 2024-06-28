//
//  CarrierModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation

struct CarrierModel: Identifiable {
    let id = UUID()
    let logo: String
    let name: String
    let email: String
    let phone: String
    
    init(
        logo: String = "",
        name: String = "",
        email: String = "",
        phone: String = ""
    ) {
        self.logo = logo
        self.name = name
        self.email = email
        self.phone = phone
    }
}
