//
//  SwiftUIView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/03.
//

import SwiftUI

struct ToolBarView<Content: View>: View {
    @Binding var action: Action
    var goBackButton: Content
    var reloadButton: Content
    var goForwardButton: Content
    
    init(
        action: Binding<Action>,
        @ViewBuilder goBackButton: () -> Content,
        @ViewBuilder reloadButton: () -> Content,
        @ViewBuilder goForwardButton: () -> Content
    ) {
        self._action = action
        self.goBackButton = goBackButton()
        self.reloadButton = reloadButton()
        self.goForwardButton = goForwardButton()
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: { action = .goBack }) {
                goBackButton
            }
            
            Spacer()
            
            Button(action: { action = .reload }) {
                reloadButton
            }
            
            Spacer()
            
            Button(action: { action = .goForward }) {
                goForwardButton
            }
        }
        .padding(.horizontal)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolBarView()
//    }
//}
