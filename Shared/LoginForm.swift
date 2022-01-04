//
//  LoginForm.swift
//  Firebase Auth Demo (iOS)
//
//  Created by Leone on 1/2/22.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    // Used to track with the launch view whether/ not to show the login form
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        
        NavigationView {
            
            // Display prompt for email and password
            Form {
                // Divides the email + password from the rest of the form
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                // Error message section
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                // Sign in button
                Button {
                    // User hits sign in here, which launches our Firebase code
                    signIn()
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign in")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Sign in")
        }
    }
    
    /*
     Use this to sign existing users in with Firebase
     */
    func signIn() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            // Update this UI code in the main thread (versus a background one)
            DispatchQueue.main.async {
                // See if the sign in was successful
                if error == nil {
                    // Dismiss this login sheet
                    formShowing = false
                }
                // Else if there was a sign in error
                else {
                    // Display localized description of the error
                    errorMessage = error!.localizedDescription
                }
            }
            
        }
        
    }
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        
        // Able to pass in a constant binding here
        LoginForm(formShowing: Binding.constant(true))
    }
}
