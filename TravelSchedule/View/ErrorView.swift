//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 19.04.2024.
//

import SwiftUI

struct ErrorView: View {
    
    enum ErrorType {
        case noInternet
        case serverError
    }
    
    @Environment(\.dismiss) private var dismiss
    @State var errorType: ErrorType
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack {
                switch errorType {
                case .noInternet:
                    Image(.noInet)
                case .serverError:
                    Image(.serverErr)
                }
                Text(errorType == .noInternet ? Constant.noInternet : Constant.serverErr)
                    .font(.bold24)
                    .foregroundStyle(.blackApp)
                    .padding()
            }
        }
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    ErrorView(errorType: .noInternet)
}
