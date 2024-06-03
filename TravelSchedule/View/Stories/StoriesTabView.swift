import SwiftUI

struct StoriesTabView: View {
    let stories: [StoryModel]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories) { story in
                StoryView(story: story)
                    .onTapGesture { location in
                        if location.x < UIScreen.main.bounds.size.width / 2 {
                            didTapStoryLeft()
                        }
                        else {
                            didTapStoryRight()
                        }
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func didTapStoryLeft() {
        withAnimation {
            currentStoryIndex = max(currentStoryIndex - 1, .zero)
        }
    }
    
    func didTapStoryRight() {
        withAnimation {
            currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
        }
    }
}

#Preview {
    
    StoriesTabView(stories: [StoryModel(id: 0, imageName: "1", title: "Text1", description: "Text1", isViewed: false), StoryModel(id: 1, imageName: "2", title: "Text2", description: "Text2", isViewed: false), StoryModel(id: 2, imageName: "3", title: "Text3", description: "Text3", isViewed: false)], currentStoryIndex: .constant(1))
}
