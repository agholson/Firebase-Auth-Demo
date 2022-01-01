//
//  ContentView.swift
//  Shared
//
//  Created by Leone on 12/28/21.
//

import SwiftUI
import FirebaseAuthUI

struct ContentView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        
        VStack {
            Text("Welcome!")
            
            // Provide sign out button
            Button {
                try! FUIAuth.defaultAuthUI()?.signOut()
                
                // Set logged in to false
                loggedIn = false 
                
            } label: {
                Text("Sign out")
            }

        }
        
    }
}
