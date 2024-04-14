//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    
    @State private var from = ""
    @State private var to = ""
    
    var body: some View {
        VStack {
            Spacer()
            ZStack() {
                Rectangle()
                    .fill(.blueUniv)
                HStack(spacing: 16) {
                    VStack {
                        Spacer()
                        TextField(Constant.from, text: $from)
                            .font(.regular17)
                            .foregroundColor(.blackUniv)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Spacer()
                        TextField(Constant.to, text: $to)
                            .font(.regular17)
                            .foregroundColor(.blackUniv)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .frame(height: 96)
                    .background(Rectangle()
                        .fill(.white)
                        .cornerRadius(20))
                    Button(action: apply) {
                        Image(.change)
                    }
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white))
                }
                .padding()
            }
            .frame(height: 128)
            .cornerRadius(20)
            .padding()
            Spacer()
        }
    }
    
    private func apply() {
        //TODO: apply
        print("TODO")
    }
    
}

#Preview {
    ScheduleView()
}
