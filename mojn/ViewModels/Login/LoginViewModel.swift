//
//  LoginViewModel.swift
//  mojn
//
//  Created by Kasper Kronborg on 27/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func loginViewModel(_ viewModel: LoginViewModel, didLoginSucessfully success: Bool)
}

public class LoginViewModel: ViewModel {
    weak var delegate: LoginViewModelDelegate?
    var sid: String?
    var token: String?
    var canSubmit: Bool {
        get {
            guard let sid = sid, let token = token else { return false }
            return sid.count > 0 && token.count > 0
        }
    }
}

public extension LoginViewModel {
    func login() {
        guard let sid = sid else { return }
        guard let token = token else { return }
        let kc = Keychain.init(identifier: .credentials)
        
        kc.set(sid, key: .sid)
        kc.set(token, key: .token)
        
        delegate?.loginViewModel(self, didLoginSucessfully: true)
    }
}
