//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI

enum SelectionType {
    case departure
    case arrival
    case find
}

struct ScheduleView: View {
    
    @Binding var path: NavigationPath
    @State private var from = Constant.from
    @State private var to = Constant.to
    @State private var isClicked = false
    @State private var isFindButtonTapped = false
    @State private var showStoryView = false
    @State private var previewIndex: Int = .zero
    
    @ObservedObject private var storiesModel = StoriesModel(models: storiesData)
    
    private let rows = [GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
            VStack {
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                        ForEach(storiesModel.models) { model in
                            StoryPreviewView(model: model)
                                .onTapGesture {
                                    previewIndex = model.id
                                    showStoryView = true
                                }
                        }
                    }
                    .padding(.init(top: 24, leading: 16, bottom: 24, trailing: 16))
                }
                
                ZStack() {
                    Color.blueUniv
                    HStack(spacing: 16) {
                        VStack {
                            Spacer()
                            NavigationLink(value: SelectionType.departure) {
                                FromToTextView(type: $from)
                            }
                            Spacer()
                            NavigationLink(value: SelectionType.arrival) {
                                FromToTextView(type: $to)
                            }
                            Spacer()
                        }
                        .frame(height: 96)
                        .background(Rectangle()
                            .fill(.white)
                            .cornerRadius(20))
                        Button {
                            isClicked.toggle()
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
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                NavigationLink(value: SelectionType.find) {
                    Text(Constant.find)
                        .foregroundColor(.white)
                        .font(.bold17)
                        .frame(width: 150, height: 60)
                        .background(.blueUniv)
                        .cornerRadius(16)
                        .padding(.vertical, 16)
                        .opacity(from == Constant.from || to == Constant.to || from == Constant.to || to == Constant.from ? .zero : 1)
                }
                
                Spacer()
                Rectangle().frame(height: 1)
                    .foregroundStyle(.grayUniv)
                    .padding(.bottom,10)
            }
            .background(.whiteApp)
            .navigationDestination(for: SelectionType.self) { type in
                switch type {
                case .departure: SearchCityView(path: $path, from: $from, to: $to, selectionType: .departure)
                case .arrival: SearchCityView(path: $path, from: $from, to: $to, selectionType: .arrival)
                case .find: RoutesListView(title: "\(from) → \(to)")
                }
            }
        }
        .fullScreenCover(isPresented: $showStoryView) {
            ZStack {
                StoriesView(storiesModel: storiesModel, previewIndex: previewIndex)
            }
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .scaleEffect(showStoryView ? .zero : 1)
        .animation(.easeInOut(duration: 0.6), value: showStoryView)
    }
}

struct RotateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .rotationEffect(configuration.isPressed ? -Angle(radians: .pi) : .zero)
    }
}

#Preview {
    ScheduleView(path: .constant(NavigationPath()))
}
