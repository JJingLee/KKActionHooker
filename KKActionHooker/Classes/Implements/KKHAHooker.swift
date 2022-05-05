//
//  KKHAHooker.swift
//  KKActionHooker
//
//  Created by KKday on 2022/5/5.
//

import Foundation

public class KKHAHooker : KKActionHooker {
    var _imp : _KKActionHooker?
    init(imp : _KKActionHooker) {
        _imp = imp
    }
    public func hookAction(hookName: String, action: @escaping () -> Void) {
        _imp?.hookAction(hookName: hookName, action: action)
    }
    public func catchError(action:@escaping(KKActionHooksError)->Void) {
        _imp?.catchError(action: action)
    }
    public func actionNames()->[String] {
        _imp?.actionNames() ?? []
    }
}
