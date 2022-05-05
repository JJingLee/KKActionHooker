//
//  KKActionHooksError.swift
//  KKActionHooker
//
//  Created by KKday on 2022/5/5.
//

import Foundation

public protocol KKActionHooksError : Error {
    var name : String { get }
}
