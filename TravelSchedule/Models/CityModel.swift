//
//  CityModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 20.04.2024.
//

import Foundation

struct CityModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stations: [String]
}
