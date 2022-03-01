//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/03/01.
//

import SwiftUI
import WebKit

public struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    @Binding var statusCode: Int
    
    public init(url: URL, statusCode: Binding<Int>) {
        self.url = url
        self._statusCode = statusCode
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator
        
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, statusCode: $statusCode)
    }
    
    static func resetCache() {
        // TODO: Taskで書き換える
        DispatchQueue.main.async {
            WKWebsiteDataStore
                .default()
                .removeData(
                    ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                    modifiedSince: Date(timeIntervalSince1970: 0),
                    completionHandler: {})
        }
    }
}

extension WebViewRepresentable {
    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        private var parent: WebViewRepresentable
        @Binding var statusCode: Int
        
        init(_ parent: WebViewRepresentable, statusCode: Binding<Int>) {
            self.parent = parent
            self._statusCode = statusCode
        }
        
        public func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationResponse: WKNavigationResponse,
            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
        ) {
            if let response = navigationResponse.response as? HTTPURLResponse {
                self.statusCode = response.statusCode
            }
            
            decisionHandler(.allow)
        }
        
        public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            scrollView.pinchGestureRecognizer?.isEnabled = false
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            WebViewRepresentable.resetCache()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            WebViewRepresentable.resetCache()
        }
    }
}
