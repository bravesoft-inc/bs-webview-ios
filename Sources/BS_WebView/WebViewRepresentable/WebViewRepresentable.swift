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
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
    }
}
