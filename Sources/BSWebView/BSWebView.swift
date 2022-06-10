//
//  BSWebView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/01.
//

import SwiftUI
import Combine
import WebKit

public struct BSWebView: UIViewRepresentable {
    private var webView: WKWebView?
    private let request: URLRequest
    private let config: BSWebViewConfig
    
    public var statusCodePublisher: PassthroughSubject<Int, Never> = .init()
    public var errorCodePublisher: PassthroughSubject<Int, Never> = .init()
    public var canGoBackPublisher: PassthroughSubject<Bool, Never> = .init()
    public var canGoForwardPublisher: PassthroughSubject<Bool, Never> = .init()

    public init(url: URL, config: BSWebViewConfig = .default) {
        self.webView = WKWebView()
        self.request = URLRequest(url: url)
        self.config = config
    }
    
    public init(request: URLRequest, config: BSWebViewConfig = .default) {
        self.webView = WKWebView()
        self.request = request
        self.config = config
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> WKWebView {
        webView!.load(request)
        webView!.uiDelegate = context.coordinator
        webView!.navigationDelegate = context.coordinator
        webView!.scrollView.delegate = context.coordinator

        return webView!
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    public func goBack() {
        webView?.goBack()
    }

    public func goForward() {
        webView?.goForward()
    }

    public func refresh() {
//        if webView?.url == nil {
//            webView?.load(request)
//        } else {
//            webView?.reload()
//        }
        webView?.load(request)
    }
}

extension BSWebView {
    final public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        private var parent: BSWebView

        public init(_ parent: BSWebView) {
            self.parent = parent
        }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard let response = navigationResponse.response as? HTTPURLResponse else {
                parent.statusCodePublisher.send(404)
                return decisionHandler(.cancel)
            }

            let statusCode: Int = response.statusCode
            parent.statusCodePublisher.send(statusCode)

            decisionHandler(.allow)
        }

        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                switch parent.config.targetBlankTappedType {
                case .openInExternalBrowser:
                    if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                case .internalTransition:
                    webView.load(navigationAction.request)
                case .noop:
                    break
                }
            }
            
            return nil
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation?) {
            parent.canGoBackPublisher.send(webView.canGoBack)
            parent.canGoForwardPublisher.send(webView.canGoForward)
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation?, withError error: Error) {
            let nsError = error as NSError
            parent.errorCodePublisher.send(nsError.code)
            parent.statusCodePublisher.send(0)
        }

        public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            scrollView.pinchGestureRecognizer?.isEnabled = false
        }
    }
}
