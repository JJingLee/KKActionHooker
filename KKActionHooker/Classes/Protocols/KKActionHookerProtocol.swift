//
//  KKActionHooker.swift
//  KKActionHooker
//
//  Created by KKday on 2022/5/5.
//

import Foundation

public protocol KKActionHooker {
    func hookAction(hookName:String,action:@escaping()->Void)
    func catchError(action:@escaping(KKActionHooksError)->Void)
    func actionNames()->[String]
}

protocol _KKActionHooker {
    func hookAction(hookName:String,action:@escaping()->Void)
    func catchError(action:@escaping(KKActionHooksError)->Void)
    func actionNames()->[String]
}
