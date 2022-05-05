//
//  KKViewBuilderError.swift
//  KKActionHooker_Example
//
//  Created by KKday on 2022/5/5.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import KKActionHooker

public struct KKViewBuilderError : KKActionHooksError {
    public let name : String
    public let hashCode : Int
}
