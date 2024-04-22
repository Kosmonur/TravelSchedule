//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var path: NavigationPath
    @State private var from = ""
    @State private var to = ""
    @State private var isClicked = false
    @State private var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            ZStack() {
                Rectangle()
                    .fill(.blueUniv)
                HStack(spacing: 16) {
                    VStack {
                        Spacer()
                        NavigationLink(value: SelectionType.departure) {
                            FromToTextView(type: from)
                        }
                        Spacer()
                        NavigationLink(value: SelectionType.arrival) {
                            FromToTextView(type: to)
                        }
                        Spacer()
                    }
                    .frame(height: 96)
                    .background(Rectangle()
                        .fill(.white)
                        .cornerRadius(20))
                    Button {
                        isClicked.toggle()
                        swap(&viewModel.fromCity, &viewModel.toCity)
                        swap(&viewModel.fromStation, &viewModel.toStation)
                        swap(&from, &to)
                    } label: {
                        Image(.change)
                    }
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white))
                    .buttonStyle(RotateButtonStyle())
                }
                .padding()
            }
            .frame(height: 128)
            .cornerRadius(20)
            .padding()
            Spacer()
            Rectangle().frame(height: 1)
                .foregroundStyle(.grayUniv)
                .padding(.bottom,10)
        }
        .background(.whiteApp)
        .onAppear {
            if let fromCity = viewModel.fromCity,
               let fromStation = viewModel.fromStation {
                from = "\(fromCity) (\(fromStation))"
            } else {
                from = Constant.from
            }
            if let toCity = viewModel.toCity,
               let toStation = viewModel.toStation {
                to = "\(toCity) (\(toStation))"
            } else {
                to = Constant.to
            }
        }
        .navigationDestination(for: SelectionType.self) { type in
            switch type {
            case .departure: SearchCityView(path: $path,
                                            selectionType: .departure,
                                            viewModel: viewModel)
            case .arrival: SearchCityView(path: $path,
                                          selectionType: .arrival,
                                          viewModel: viewModel)
            }
        }
    }
}

struct RotateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .rotationEffect(configuration.isPressed ? -Angle(radians: .pi) : .zero)
    }
}

#Preview {
    ScheduleView(path: ContentView().$path)
}
