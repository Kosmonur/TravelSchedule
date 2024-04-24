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
}
