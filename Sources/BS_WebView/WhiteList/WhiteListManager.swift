//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/03/01.
//

import Combine
import Foundation

//class WhiteListManager {
//    static let shared = WhiteListManager()
//    private var list: [String] = []
//    private var disposables = Set<AnyCancellable>()
//    
//    private init() {}
//    
//    deinit {
//        disposables.forEach { $0.cancel() }
//    }
//    
//    func checkDomain(_ url: URL) -> Bool {
//        guard
//            let component = URLComponents(url: url, resolvingAgainstBaseURL: true),
//            let host = component.host
//        else { return false }
//        
//        return list.contains(host)
//    }
//}
