//
//  ContentView.swift
//  Shared
//
//  Created by Leone on 12/28/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    
    @Binding var loggedIn: Bool
    @State private var name: String?
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            if name == nil {
                Text("Welcome!")
                    .font(.title)
            }
            else {
                Text("Welcome \(name!)!")
                    .font(.title)
            }
            // MARK: Sign out
            Button {
                // Tells Firebase user signed out
                try! Auth.auth().signOut()
                
                // Set logged in to false
                loggedIn = false 
                
            } label: {
                Text("Sign out")
            }
                
        } // As soon as this loads, get the person's name
        .onAppear {
            getFirstName()
        }
    }
    
    /*
     Get the first name of the user, if there is one
     */
    func getFirstName() {
        
        if let userId = Auth.auth().currentUser?.uid {
            // Get our document reference
            let docRef = Firestore.firestore().collection("users").document(userId)
            
            // Get the document here
            docRef.getDocument { snapshot, error in
                // If we have no errors, and the snapshot is not nil, then get our user's name
                if error == nil && snapshot != nil {
                    DispatchQueue.main.async {
                        // Set the name to what is stored in the database
                        name = snapshot!.get("name") as? String 
                    }
                   
                }
                
            }
        }
        
    }
   
    
}
