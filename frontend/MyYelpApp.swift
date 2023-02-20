//
//  MyYelpApp.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

@main
struct MyYelpApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // work for test launch screen

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// work for test launch screen
/*
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        return true
    }
}
*/
