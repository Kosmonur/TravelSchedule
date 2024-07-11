//
//  RouteModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 23.04.2024.
//

import Foundation

struct RouteModel: Identifiable {
    let id = UUID()
    let transfer: String
    let date: String
    let startTime: String
    let endTime: String
    let duration: String
    let carrier: CarrierModel
}