//
//  LoginForm.swift
//  Firebase Auth Demo (iOS)
//
//  Created by Leone on 12/29/21.
//

import Foundation
import SwiftUI
import FirebaseEmailAuthUI


/*
 Used to display pre-made Google login forms for authentication.
 */
struct LoginForm: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()
        
        // Ensure authUI is not nil
        guard authUI != nil else {
            return UINavigationController()
        }
        
        // Setup the list of login providers we accept e.g. Facebook, Google, etc.
        let providers = [FUIEmailAuth()]
        
        authUI!.providers = providers
        
        return authUI!.authViewController()
        
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
}
