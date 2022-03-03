//
//  SwiftUIView.swift
//  
//
//  Created by 平石　太郎 on 2022/03/03.
//

import SwiftUI

struct ToolBarView: View {
    @Binding var action: Action
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: { action = .goBack }) {
                Image(systemName: "arrow.backward.circle.fill")
            }
            
            Spacer()
            
            Button(action: { action = .reload }) {
                Image(systemName: "doc.circle")
            }
            
            Spacer()
            
            Button(action: { action = .goForward }) {
                Image(systemName: "arrow.forward.circle.fill")
            }
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolBarView()
//    }
//}
