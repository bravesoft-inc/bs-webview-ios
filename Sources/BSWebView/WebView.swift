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
    var reloadButton: Content
    var forwardButton: Content
    
    public init(
        statusCode: Binding<Int>,
        url: URL,
        @ViewBuilder backButton: () -> Content,
        @ViewBuilder reloadButton: () -> Content,
        @ViewBuilder forwardButton: () -> Content
    ) {
        self._statusCode = statusCode
        self.url = url
        self.backButton = backButton()
        self.reloadButton = reloadButton()
        self.forwardButton = forwardButton()
    }

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
                
                Spacer()
                
                Button(action: { action = .reload }) {
                    reloadButton
                }
                
                Spacer()
                
                Button(action: { action = .goForward }) {
                    forwardButton
                }
            }
            .padding()
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
