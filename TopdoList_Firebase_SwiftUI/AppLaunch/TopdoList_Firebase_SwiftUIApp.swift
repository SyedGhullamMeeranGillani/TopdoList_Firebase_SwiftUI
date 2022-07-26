//
//  TopdoList_Firebase_SwiftUIApp.swift
//  TopdoList_Firebase_SwiftUI
//
//  Created by Syed Ghullam Meeran Gillani on 26/07/2022.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      

    return true
  }
}


@main
struct TopdoList_Firebase_SwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
