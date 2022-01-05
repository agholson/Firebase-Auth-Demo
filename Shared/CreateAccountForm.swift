//
//  CreateAccountForm.swift
//  Firebase Auth Demo (iOS)
//
//  Created by Leone on 1/3/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CreateAccountForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    
    // Holds any error messages that occur during the account crreation
    @State private var accountErrorMessage: String?
    
    var body: some View {
        NavigationView {
            
            
            Form {
                
                // Prompt for name, email, password
                Section {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                // Display any errors
                if accountErrorMessage != nil {
                    Section {
                        // Displays red error message
                        Text(accountErrorMessage!)
                            .foregroundColor(.red)
                    }
                }
                
                Button {
                    // Creates the account
                    createAccount()
                } label: {
                    
                    // Use an HStack with two Spacers to place the create account button in the center
                    HStack {
                        Spacer()
                        Text("Create account")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Create an Account")
            
            
        }
    }
    
    /*
     Takes the supplied form information, and sends it to Firebase
     */
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error != nil {
                    // Need to use this to update the code, because it controls UI elements
                    DispatchQueue.main.async {
                        accountErrorMessage = error!.localizedDescription
                    }
                    
                }
                // Else no errors occurred, so dismiss the form
                else {
                    // Hides the form
                    formShowing = false
                    
                    // Save the first name
                    saveFirstName()
                }
            }
            
            
            
        }
    }
    
    func saveFirstName() {
        
        // Ensure user is logged in
        if let currentUser = Auth.auth().currentUser {
            // Try to modify the name after trimming extra whitespace and new line characters
            let modifiedFirstName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Access our database
            let db = Firestore.firestore()
            
            // Get the current user's information
            let path = db.collection("users").document(currentUser.uid)
            
            // Set the first name to the user selected name, and create the document if it does not exist
            path.setData(["name": name]) { error in
                // If an error occurred, then show that to the user
                if let error = error {
                    accountErrorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
}

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(formShowing: Binding.constant(true))
    }
}
