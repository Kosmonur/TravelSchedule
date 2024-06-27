
import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 3
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.blueUniv)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    let numberOfSections: Int
    var body: some View {
        HStack {
            ForEach(.zero ..< numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    var body: some View {
        Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: .progressBarCornerRadius))
    }
}

#Preview {
    Color.blackApp
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.3)
                .padding()
        )
}
