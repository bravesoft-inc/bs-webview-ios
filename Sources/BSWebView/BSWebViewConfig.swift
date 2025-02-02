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
    public let targetBlankTappedType: TargetBlankTappedType
    
    public init(targetBlankTappedType: TargetBlankTappedType) {
        self.targetBlankTappedType = targetBlankTappedType
    }
    
    public static let `default`: BSWebViewConfig = BSWebViewConfig(
        targetBlankTappedType: .openInExternalBrowser
    )
}
