//
//  WebView.swift
//  TravelSchedule
//
//  Created by Александр Пичугин on 14.04.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable, Sendable {
    
    let url: URL
    @ObservedObject var viewModel: ProgressViewModel
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

extension WebView {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
    
    class Coordinator: NSObject {
        private var parent: WebView
        private var viewModel: ProgressViewModel
        private var observer: NSKeyValueObservation?
        
        init(_ parent: WebView, viewModel: ProgressViewModel) {
            self.parent = parent
            self.viewModel = viewModel
            super.init()
            
            observer = self.parent.webView.observe(\.estimatedProgress) { webView, _ in
                parent.viewModel.progress = webView.estimatedProgress
            }
        }
        
        deinit {
            observer = nil
        }
    }
}

extension WebView {
    final class ProgressViewModel: ObservableObject {
        @Published var progress: Double = .zero
        
        init (progress: Double) {
            self.progress = progress
        }
    }
}

#Preview {
    WebView(url: Constant.agreementURL, viewModel: WebView.ProgressViewModel(progress: .zero))
}
