//
//  KKHAHook.swift
//  KKActionHooker
//
//  Created by KKday on 2022/5/5.
//

import Foundation
import PromiseKit

public class KKHAHook : KKActionHooks {
    var _imp : _KKActionHooks?
    init(imp : _KKActionHooks) {
        _imp = imp
    }
    public func actionNames() -> [String] {
        _imp?.actionNames() ?? []
    }
    public func addAction(name: String, action: @escaping () -> Promise<Any>) {
        _imp?.addAction(name: name, action: action)
    }
    public func doAction(name: String) {
        _imp?.doAction(name: name)
    }
    public func sendError(err:KKActionHooksError) {
        _imp?.sendError(err: err)
    }
}
