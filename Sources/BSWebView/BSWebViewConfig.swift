//
//  File.swift
//  
//
//  Created by 斉藤　尚也 on 2022/03/28.
//

import Foundation

public enum TargetBlankTappedType {
    case openInExternalBrowser
    case internalTransition
    case noop
}

public struct BSWebViewConfig {
    let targetBlankTappedType: TargetBlankTappedType
    
    public static let `default`: BSWebViewConfig = BSWebViewConfig(
        targetBlankTappedType: .openInExternalBrowser
    )
}
