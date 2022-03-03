//
//  SwiftUIView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/03.
//

import SwiftUI

public struct WebView<Content: View>: View {
    @Binding var statusCode: Int
    @State var action: Action = .none
    private let url: URL
    var backButton: Content
//    var reloadButton: Content
//    var forwardButton: Content
    
    public init(
        statusCode: Binding<Int>,
        url: URL,
        @ViewBuilder backButton: () -> Content
    ) {
        self._statusCode = statusCode
        self.url = url
        self.backButton = backButton()
    }
    
//    public init(
//        url: URL,
//        statusCode: Binding<Int>,
//        @ViewBuilder backButtonIcon: () -> Content,
//        @ViewBuilder reloadButton: () -> Content,
//        @ViewBuilder goForwardButton: () -> Content
//    ) {
//        self.url = url
//        self._statusCode = statusCode
//        self.action = action
//        self.backButtonIcon = backButtonIcon()
//        self.reloadButton = reloadButton()
//        self.goForwardButton = goForwardButton()
//        self.goBackButton = goBackButton()
//        self.reloadButton = reloadButton()
//        self.goForwardButton = goForwardButton()
//    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            WebViewRepresentable(
                url: url,
                statusCode: $statusCode,
                action: $action
            )
            
            HStack(alignment: .center, spacing: 0) {
                Button(action: { action = .goBack }) {
                    backButton
                }
            }
            
//            ToolBarView(
//                action: $action,
//                goBackButton: {
//                    goBackButton
//                  Image(systemName: "arrow.backward.circle.fill")
//                        .font(.system(size: 28))
//                },
//                reloadButton: {
//                    Image(systemName: "doc.circle")
//                        .font(.system(size: 28))
//                },
//                goForwardButton: {
//                    Image(systemName: "arrow.forward.circle.fill")
//                        .font(.system(size: 28))
//                })
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
