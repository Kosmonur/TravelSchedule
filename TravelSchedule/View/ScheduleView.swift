//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI
import Combine

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
    @State private var modelsForShow: [StoryModel] = []
    @State private var cancellable = Set<AnyCancellable>()
    
    
    @ObservedObject private var storyPreviewViewModel = StoryPreviewViewModel()
    
    private let rows = [GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                        ForEach(storyPreviewViewModel.models) { model in
                            StoryPreviewView(model: model)
                                .onTapGesture {
                                    modelsForShow = storyPreviewViewModel.models
                                        .filter{$0.id >= model.id}
                                        .flatMap {$0.storyModels}
                                        .enumerated()
                                        .map { StoryModel(id: $0,
                                                          imageName: $1.imageName,
                                                          title: $1.title,
                                                          description: $1.description,
                                                          isViewed: $1.isViewed)
                                        }
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
                        .opacity(from == Constant.from || to == Constant.to || from == Constant.to || to == Constant.from ? 0 : 1)
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
            
            if showStoryView {
                
                ZStack(alignment: .topTrailing) {
                    let storiesView = StoriesView(stories: modelsForShow)
                    storiesView
                        .onAppear {
                            storiesView.storiesIsVisible
                                .assign(to: \.showStoryView, on: self)
                                .store(in: &cancellable)
                        }
                    
                    CloseButton(action: {
                        showStoryView = false
                    })
                    .padding(.top, 50)
                    .padding(.trailing, 12)
                    
                }
//                .transition(.asymmetric(insertion: .slide, removal: .scale))
 //               .transition(.push(from: .bottom))
 //               .transition(.slide)
//                .scaleEffect(showStoryView ? 1 : 0.1)
//                .opacity(showStoryView ? 1 : 0)
                
            }
        }
        .animation(.easeInOut(duration: 1), value: showStoryView)
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
