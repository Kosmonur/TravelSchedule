import SwiftUI
import Combine

struct StoriesProgressBar: View {
    
    @Binding var currentProgress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    private let storiesCount: Int
    private let timerConfiguration: TimerConfiguration
    
    init(storiesCount: Int, timerConfiguration: TimerConfiguration, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration)
    }
    
    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: currentProgress)
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
    }
    
    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
}

extension StoriesProgressBar {
    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

