//
//  SignUpViewModel.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 4/12/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthManager {
    
    // Check that fields are not empty (just email and password)
    static func validateFields(_ email: String?, _ password: String?) -> String? {
        // Validate text fields
        if email == "" || password == "" {
            return Constants.Errors.emptyFieldsError
        }
        // Fields aren't empty, thus valid
        return nil
    }
    
    // Check the fields and validate for correctness. If everything is correct, this method returns nil. Otherwise it returns the error message. (team name, email, and password)
    static func validateFields(_ teamName: String?, _ email: String?, _ password: String?) -> String? {
        
        // Check that all fields are filled in
        if teamName == "" || email == "" || password == "" {
            return Constants.Errors.emptyFieldsError
        }
        
        // Check if the password is secure
        if isPasswordValid(password!) == false {
            // Password isn't secure enough
            return Constants.Errors.insecurePasswordError
        }
        
        // Check if email format is valid
        if isEmailValid(email!) == false {
            return Constants.Errors.invalidEmailError
        }
        
        return nil
    }
    
    static func createUser(_ teamName: String, _ email: String, _ password: String) -> String? {
        
        var returnError: String? = nil
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            // Check for errors
            if err != nil {
                // There was an error creating the user
                returnError = Constants.Errors.userCreationError
            }
            else {
                // User was created successfully, now store the team name (validated as not empty)
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["teamname": teamName, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        // Show error message
                        returnError = Constants.Errors.userSavingError
                    }
                }
            }
        }
        // Return creation/saving error, if any, otherwise nil
        return returnError
    }
    
    static func signIn(_ email: String, _ password: String) -> String? {
        
        var returnError: String? = nil
        
        // Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                // Coudn't sign in
                returnError = err!.localizedDescription
            }
        }
        // Return login error, if any, otherwise nil
        return returnError
    }
    
    //MARK: Private Methods
    private static func isPasswordValid(_ password : String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?*])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    private static func isEmailValid(_ email : String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}