//
//  ContentView.swift
//  Sample
//
//  Created by 斉藤　尚也 on 2022/03/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {}) {
                    Text("target=blankを外部ブラウザで開く")
                }
                NavigationLink(destination: {}) {
                    Text("target=blankは内部遷移する")
                }
            }
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
