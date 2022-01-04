//
//  LaunchView.swift
//  Firebase Auth Demo (iOS)
//
//  Created by Leone on 1/1/22.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    // Assume user is not signed in
    @State var loggedIn = false
    
    // Determines whether/ not to show the loginForm
    @State var loginFormShowing = false
    
    // Tracks whether/ not to display the create account form
    @State var createAccountFormShowing = false
    
    var body: some View {
        
        // Check if person is loggedIN
        if !loggedIn {
            
            VStack(spacing: 20) {
                // MARK: Sign in
                Button {
                    
                    // Show the loginForm, when user clicks to sign in
                    loginFormShowing = true
                    
                } label: {
                    Text("Sign in")
                }
                // Once UI appears, see if person id logged in, when this is dismissed, check the login status
                .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                    LoginForm(formShowing: $loginFormShowing)
                }
                
                // MARK: Create Account
                Button {
                    createAccountFormShowing = true
                } label: {
                    Text("Create account")
                }
                .sheet(isPresented: $createAccountFormShowing, onDismiss: checkLogin) {
                    CreateAccountForm(formShowing: $createAccountFormShowing)
                }

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
        loggedIn = Auth.auth().currentUser == nil ? false : true
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
