//
//  Firebase_Auth_DemoApp.swift
//  Shared
//
//  Created by Leone on 12/28/21.
//

import SwiftUI
import Firebase

@main
struct Firebase_Auth_DemoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
