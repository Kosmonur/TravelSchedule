//
//  TravelView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 28.06.2024.
//

import SwiftUI

enum SelectionType {
    case departure
    case arrival
    case find
}

struct TravelView: View {
    
    @ObservedObject var travelViewModel: TravelViewModel
    
    @Binding var path: NavigationPath
    @State private var animate = false
    @State private var isFindButtonTapped = false
    @State private var showStoryView = false
    
    private let rows = [GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
            VStack {
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                        ForEach(travelViewModel.storiesViewModel.models) { model in
                            StoryPreviewView(model: model)
                                .onTapGesture {
                                    travelViewModel.storiesViewModel.previewIndex = model.id
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
                                FromToTextView(type: $travelViewModel.from)
                            }
                            Spacer()
                            NavigationLink(value: SelectionType.arrival) {
                                FromToTextView(type: $travelViewModel.to)
                            }
                            Spacer()
                        }
                        .frame(height: 96)
                        .background(Rectangle()
                            .fill(.white)
                            .cornerRadius(20))
                        Button {
                            withAnimation(.easeInOut(duration: 0.7)) {
                                animate.toggle()
                                travelViewModel.swapFromTo()
                            }
                        } label: {
                            Image(.change)
                        }
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color.white))
                        .rotation3DEffect(animate ? .radians(.pi) : .zero, axis: (x: 1.0, y: .zero, z: .zero)
                        )
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
                        .opacity(travelViewModel.findButtonIsHidden ? .zero : 1)
                }
                
                Spacer()
                Rectangle().frame(height: 1)
                    .foregroundStyle(.grayUniv)
                    .padding(.bottom,10)
            }
            .background(.whiteApp)
            .navigationDestination(for: SelectionType.self) { type in
                switch type {
                case .departure, .arrival: SearchCityView(citiesViewModel: travelViewModel.citiesViewModel, path: $path, from: $travelViewModel.from, to: $travelViewModel.to, selectionType: type)
                case .find: RoutesListView(routesViewModel: RoutesViewModel(fromStation:  travelViewModel.from, toStation: travelViewModel.to))
                }
            }
        }
        .fullScreenCover(isPresented: $showStoryView) {
            ZStack {
                StoriesView(storiesModel: travelViewModel.storiesViewModel)
            }
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .scaleEffect(showStoryView ? .zero : 1)
        .animation(.easeInOut(duration: 0.6), value: showStoryView)
    }
}

#Preview {
    TravelView(travelViewModel: TravelViewModel(), path: .constant(NavigationPath()))
}
