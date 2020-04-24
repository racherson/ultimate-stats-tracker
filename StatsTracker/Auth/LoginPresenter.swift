//
//  LoginPresenter.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 4/22/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

class LoginPresenter: Presenter {
    
    //MARK: Properties
    weak var delegate: SignUpAndLoginPresenterDelegate?
    let vc: LoginViewController
    var authManager: AuthenticationManager = FirebaseAuthManager()
    
    //MARK: Initialization
    init(vc: LoginViewController, delegate: SignUpAndLoginPresenterDelegate?) {
        self.vc = vc
        self.delegate = delegate
        self.authManager.loginErrorHandler = self
        
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
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
    
    func loginPressed(email: String?, password: String?) {
        // Attempt to sign in the user
        authManager.signIn(email, password)
    }
}

//MARK: LoginAuthDelegate
extension LoginPresenter: LoginAuthDelegate {
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
