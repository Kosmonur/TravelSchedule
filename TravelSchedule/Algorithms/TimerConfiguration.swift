import Foundation

struct TimerConfiguration {
    var storiesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5, //10,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.storiesCount = storiesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
