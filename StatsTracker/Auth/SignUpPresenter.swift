//
//  SignUpPresenter.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 4/22/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

protocol SignUpAndLoginPresenterDelegate: class {
    func cancelPressed()
    func transitionToTabs()
}

class SignUpPresenter: Presenter {

    //MARK: Properties
    weak var delegate: SignUpAndLoginPresenterDelegate?
    let vc: SignUpViewController
    var authManager: AuthenticationManager = FirebaseAuthManager()
    
    //MARK: Initialization
    init(vc: SignUpViewController, delegate: SignUpAndLoginPresenterDelegate?) {
        self.vc = vc
        self.delegate = delegate
        self.authManager.createUserErrorHandler = self
    }
}

//MARK: SignUpPresenterProtocol
extension SignUpPresenter: SignUpPresenterProtocol {
    
    func cancelPressed() {
        delegate?.cancelPressed()
    }
    
    func transitionToTabs() {
        delegate?.transitionToTabs()
    }
    
    func onViewWillAppear() {
        // Listener for changes in authentication
        authManager.addAuthListener()
    }
    
    func onviewWillDisappear() {
        authManager.removeAuthListener()
    }
    
    func signUpPressed(name: String?, email: String?, password: String?) {
        // Attempt to create user
        authManager.createUser(name, email, password)
    }
}

//MARK: CreateUserAuthDelegate
extension SignUpPresenter: CreateUserAuthDelegate {

    func displayError(with error: Error) {
        guard let authError = error as? AuthError else {
            // Not an AuthError specific type
            self.vc.showError(error.localizedDescription)
            return
        }
        self.vc.showError(authError.errorDescription!)
    }
    
    func onAuthHandleChange() {
        transitionToTabs()
    }
}