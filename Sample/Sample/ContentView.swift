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
            Form {
                Section {
                    NavigationLink(destination: TargetBlankSafari()) {
                        Text("外部ブラウザで開く")
                    }
                    NavigationLink(destination: TargetBlankWebView()) {
                        Text("内部遷移する")
                    }
                } header: {
                    Text("target=blank")
                }
            }
            .navigationTitle("BSWebView")
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
