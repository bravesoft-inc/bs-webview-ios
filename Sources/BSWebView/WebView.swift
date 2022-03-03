//
//  SwiftUIView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/03.
//

import SwiftUI

public struct WebView: View {
    private let url: URL
    @Binding var statusCode: Int
    @State var action: Action = .none
    
    public init(
        url: URL,
        statusCode: Binding<Int>
    ) {
        self.url = url
        self._statusCode = statusCode
        self.action = action
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            WebViewRepresentable(
                url: url,
                statusCode: $statusCode,
                action: $action
            )
            ToolBarView(action: $action)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
