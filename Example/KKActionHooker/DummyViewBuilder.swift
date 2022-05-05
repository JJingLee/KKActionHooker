//
//  DummyViewBuilder.swift
//  KKActionHooker_Example
//
//  Created by KKday on 2022/5/5.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import KKActionHooker
import PromiseKit

//MARK: Builder Implementer
public class DummyViewBuilder : UIViewController {
    public var hookManager: KKHAHooksManager = KKHAHooksManager()
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .blue
        sendATestError()
        addActions()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        hookManager.asHooks.doAction(name: DummyViewBuilderHooks.viewLoad)
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hookManager.asHooks.doAction(name: DummyViewBuilderHooks.viewAppear)
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hookManager.asHooks.doAction(name: DummyViewBuilderHooks.viewDisappear)
    }
    
    //MARK:private funcs
    private func sendATestError() {
        let testErr = KKViewBuilderError(name: DummyViewBuilderError.DVB_test_001,
                                         hashCode: DummyViewBuilderError.DVB_test_001.hashValue)
        hookManager.asHooks.sendError(err:testErr)
    }
    private func addActions() {
        //add at beginning to make sure user could check.
        hookManager.asHooks.addAction(name: DummyViewBuilderHooks.viewLoad) { Promise<Any>.init { $0.fulfill(()) }}
        hookManager.asHooks.addAction(name: DummyViewBuilderHooks.viewAppear) { Promise<Any>.init { $0.fulfill(()) }}
        hookManager.asHooks.addAction(name: DummyViewBuilderHooks.viewDisappear) { Promise<Any>.init { $0.fulfill(()) }}
    }
    #if DENUG
    deinit { print("\(String(describing: self)) deinit") }
    #endif
}
