//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 24.04.2024.
//

import Foundation

final class CarrierViewModel: ObservableObject {
    
    @Published var carriers: [CarrierModel]
    
    init() {
        self.carriers = [
            CarrierModel(logo: "rzhd", name: "ОАО «РЖД»", email: "i.lozgkina@yandex.ru", phone: "+7 (904) 329-27-71"),
            CarrierModel(logo: "fgk", name: "ОАО «Федеральная государственная компания»", email: "pupkin@yandex.ru", phone: "+7 (904) 329-27-71"),
            CarrierModel(logo: "uralLog", name: "ОАО «Уральские поездатые поезда»", email: "parovoz@yandex.ru", phone: "+7 (123) 234-00-00")
        ]
    }
    
    func getCarrierWithLogo(logo: String) -> CarrierModel {
        carriers.filter { $0.logo == logo }.first ?? .init()
    }
}

