# KKActionHooker

[![CI Status](https://img.shields.io/travis/daniellee/KKActionHooker.svg?style=flat)](https://travis-ci.org/daniellee/KKActionHooker)
[![Version](https://img.shields.io/cocoapods/v/KKActionHooker.svg?style=flat)](https://cocoapods.org/pods/KKActionHooker)
[![License](https://img.shields.io/cocoapods/l/KKActionHooker.svg?style=flat)](https://cocoapods.org/pods/KKActionHooker)
[![Platform](https://img.shields.io/cocoapods/p/KKActionHooker.svg?style=flat)](https://cocoapods.org/pods/KKActionHooker)

## Concept
To develope a strictly framework, to standarlize actions and flows is one of the most import to get to the way on commodification.
KKActionHook is the solution to scalfold among framework users and framework developers to have a standard communication standard.

|   framework Users   |
|------------------------
|vvv need to listen to lifeCycle & actions
|^^^ need to expose lifeCycle & abilities
|   framework Developer   |


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Hooker for framework user, hook for framework developer.

example code:
```Swift
    //Framework Users, see in Example for KKActionHooker/ViewController
    private func printViewBuilderDefaultLifeCycles() {
        //print all hooks
        if let vbHookActions = viewBuilder?.hookManager.asHooker.actionNames() {
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
```

```Swift
  //Framework developer User, see in  Example for KKActionHooker/DummyViewBuilder
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
```

## Requirements

## Installation

KKActionHooker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KKActionHooker'
```

## Author

daniellee, daniel.lee@kkday.com

## License

KKActionHooker is available under the MIT license. See the LICENSE file for more info.
