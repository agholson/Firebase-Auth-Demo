//
//  LaunchView.swift
//  Firebase Auth Demo (iOS)
//
//  Created by Leone on 1/1/22.
//

import SwiftUI
import FirebaseEmailAuthUI

struct LaunchView: View {
    
    // Assume user is not signed in
    @State var loggedIn = false
    
    // Determines whether/ not to show the loginForm
    @State var loginFormShowing = false
    
    var body: some View {
        
        // Check if person is loggedIN
        if !loggedIn {
        
            Button {
                
                // Show the loginForm, when user clicks to sign in
                loginFormShowing = true
                
            } label: {
                Text("Sign in")
            }
            // Once UI appears, see if person id logged in, when this is dismissed, check the login status
            .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                LoginForm()
            }
            .onAppear {
                // Determines if person is not logged in 
                checkLogin()
            }
        }
        else {
            // Show logged in view
            ContentView(loggedIn: $loggedIn)
                
        }
        
    }
    
    /*
     Determines whether/ not the user is logged in
     It will also clear the current signed in user 
     */
    func checkLogin() {
        
        // Check if the user is logged in, if nill, then it means user is not, else we set to true
        loggedIn = FUIAuth.defaultAuthUI()?.auth?.currentUser == nil ? false : true
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
