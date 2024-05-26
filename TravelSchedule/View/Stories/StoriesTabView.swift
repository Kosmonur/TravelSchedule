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
        currentStoryIndex = max(currentStoryIndex - 1, .zero)
    }
    
    func didTapStoryRight() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
}

#Preview {
    StoriesTabView(stories: StoryViewModel().model.filter {(0...3).contains($0.id)}, currentStoryIndex: .constant(0))
}
