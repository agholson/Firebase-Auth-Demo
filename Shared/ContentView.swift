//
//  ContentView.swift
//  Shared
//
//  Created by Leone on 12/28/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        
        VStack {
            Text("Welcome!")
            
            // Provide sign out button
            Button {
                // Tells Firebase user signed out
                try! Auth.auth().signOut()
                
                // Set logged in to false
                loggedIn = false 
                
            } label: {
                Text("Sign out")
            }

        }
        
    }
}
