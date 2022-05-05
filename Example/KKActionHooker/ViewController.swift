//
//  ViewController.swift
//  KKActionHooker
//
//  Created by daniellee on 05/04/2022.
//  Copyright (c) 2022 daniellee. All rights reserved.
//

import UIKit
import PromiseKit
import KKActionHooker

//MARK: Builder User
class ViewController: UIViewController {
    var viewBuilder : DummyViewBuilder? = DummyViewBuilder()
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEBUG
        printViewBuilderDefaultLifeCycles()
#endif
        hookViewBuilderLifeCycles()
        catchViewBuilderErrors()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popDemoViewBuilderView()
    }
    
    //MARK: private funcs
    private func popDemoViewBuilderView() {
        guard let vb = viewBuilder else {return}
        self.present(vb, animated: true)
    }
    private func printViewBuilderDefaultLifeCycles() {
        //print all hooks
        if let vbHookActions = viewBuilder?.hookManager.asHooks.actionNames() {
            print("actions : \(vbHookActions)")
        }
    }
    private func hookViewBuilderLifeCycles(){
        viewBuilder?.hookManager.asHooker.hookAction(hookName: DummyViewBuilderHooks.viewAppear) {
            print("Make some noise")
            //close shimmer
        }
        viewBuilder?.hookManager.asHooker.hookAction(hookName: DummyViewBuilderHooks.viewDisappear) {
            [weak self] in
            print("vb disappear")
            self?.viewBuilder = nil
        }
    }
    private func catchViewBuilderErrors() {
        //hook error
        viewBuilder?.hookManager.asHooker.catchError(action: { err in
            if err.name == DummyViewBuilderError.DVB_test_001 {
                print("error : DVB_test_001")
            }else {
                print("unknown error : \(err.name)")
            }
        })
    }
}
