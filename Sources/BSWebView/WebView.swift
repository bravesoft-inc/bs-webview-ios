//
//  SwiftUIView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/03.
//

import SwiftUI

struct WebView: View {
    private let url: URL
    @Binding var statusCode: Int
    @State var action: Action = .none
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            WebViewRepresentable(url: url, statusCode: $statusCode)
            ToolBarView(action: $action)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
