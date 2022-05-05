import PromiseKit
import Foundation

public class KKHAHooksManager : _KKActionHooker,_KKActionHooks {
    private var actions : [String : ()->Promise<Any>] = [:]
    private var hooks : [String : [()->Void]]=[:]
    private var errCatchers : [(KKActionHooksError) -> Void] = []
    
    public required init() {
        
    }
    
    public var asHooker : KKActionHooker {
        return KKHAHooker(imp: self)
    }
    public var asHooks : KKActionHooks {
        return KKHAHook(imp: self)
    }
    internal func actionNames()->[String] {
        return actions.keys.sorted()
    }
    internal func addAction(name:String, action :@escaping()->Promise<Any>) {
        actions[name] = action
    }
    internal func doAction(name:String) {
        actions[name]?().catch({ [weak self]err in
            let _err = KKHAHooksManagerError(name:"action failed")
            self?.sendError(err: _err)
        }).finally { [weak self] in
            self?.hooks[name]?.forEach { $0() }
        }
    }
    internal func hookAction(hookName: String, action: @escaping () -> Void) {
        objc_sync_enter(self)
        defer {objc_sync_exit(self)}
        var theHooks = hooks[hookName] ?? []
        theHooks.append(action)
        hooks[hookName] = theHooks
    }
    func catchError(action: @escaping (KKActionHooksError) -> Void) {
        errCatchers.append(action)
    }
    func sendError(err: KKActionHooksError) {
        errCatchers.forEach{ $0(err) }
    }
    #if DEBUG
    deinit { print("\(String(describing: self)) deinit") }
    #endif
}
