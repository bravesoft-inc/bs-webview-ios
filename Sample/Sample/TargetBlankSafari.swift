//
//  TargetBlankSafari.swift
//  Sample
//
//  Created by 斉藤　尚也 on 2022/03/28.
//

import SwiftUI
import BSWebView

struct TargetBlankSafari: View {
    var body: some View {
        if let url = URL(string: "https://www.tagindex.com/html_tag/link/a_target.html") {
            BSWebView(url: url)
        } else {
            Text("Not Found")
        }
    }
}

struct TargetBlankSafari_Previews: PreviewProvider {
    static var previews: some View {
        TargetBlankSafari()
    }
}
