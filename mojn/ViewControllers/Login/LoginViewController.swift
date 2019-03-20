//
//  LoginViewController.swift
//  mojn
//
//  Created by Kasper Kronborg on 28/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

public class LoginViewController: GenericViewController<LoginViewModel, LoginRootView>, UITextFieldDelegate {
    public override func viewDidLoad() {
        self.rootView.apply(Stylesheet.root)
        
        rootView.submitButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        rootView.sidTextField.addTarget(self, action: #selector(sidTextFieldDidChange(_:)), for: .editingChanged)
        rootView.tokenTextField.addTarget(self, action: #selector(tokenTextFieldDidChange(_:)), for: .editingChanged)
        
        viewModel.delegate = self

    }
    
    @objc func loginButtonPressed() {
        if(viewModel.canSubmit) {
            viewModel.login()
        }
    }
    
    @objc func sidTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.sid = text
        }
    }
    
    @objc func tokenTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.token = text
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(_ viewModel: LoginViewModel, didLoginSucessfully success: Bool) {
        if (success) {
            dismiss(animated: true, completion: nil)
        }
    }
}

public extension LoginViewController {
    enum Stylesheet {
        static let root = Style<View> {
            $0.backgroundColor = UIColor(hexString: "#f7e2dd")
        }
    }
}

