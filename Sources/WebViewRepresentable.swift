//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/03/01.
//

import SwiftUI
import WebKit

struct BSWebView: UIViewRepresentable {
    private var webView: WKWebView?
    private let request: URLRequest
    private let onChangeStatusCode: ((Int) -> Void)?
    
    public init(request: URLRequest, onChangeStatusCode: ((Int) -> Void)? = nil) {
        self.webView = WKWebView()
        self.request = request
        self.onChangeStatusCode = onChangeStatusCode
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView!.load(URLRequest(url: url))
        webView!.uiDelegate = context.coordinator
        webView!.navigationDelegate = context.coordinator
        webView!.scrollView.delegate = context.coordinator
        
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    public func goBack() {
        webView?.goBack()
    }
    
    public func goForward() {
        webView?.goForward()
    }
    
    public func refresh() {
        webView?.reload()
    }
}

extension BSWebView {
    final private class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        var parent: BSWebView
        
        init(_ parent: BSWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let response = navigationResponse.response as? HTTPURLResponse {
                parent.onChangeStatusCode(response.statusCode)
            }
            webView.goBack()
            
            decisionHandler(.allow)
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            scrollView.pinchGestureRecognizer?.isEnabled = false
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            WebViewRepresentable.resetCache()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            WebViewRepresentable.resetCache()
        }
    }
}
