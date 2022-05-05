//
//  KKActionHooks.swift
//  KKActionHooker
//
//  Created by KKday on 2022/5/5.
//

import Foundation
import PromiseKit

public protocol KKActionHooks {
    func actionNames()->[String]
    func addAction(name:String, action :@escaping()->Promise<Any>)
    func doAction(name:String)
    func sendError(err:KKActionHooksError)
}
protocol _KKActionHooks {
    func actionNames()->[String]
    func addAction(name:String, action :@escaping()->Promise<Any>)
    func doAction(name:String)
    func sendError(err:KKActionHooksError)
}
