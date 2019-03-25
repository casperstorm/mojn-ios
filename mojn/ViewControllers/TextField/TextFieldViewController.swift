//
//  TextFieldViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 22/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

protocol TextFieldViewControllerDelegate: class {
    func textFieldViewController(_ viewController: TextFieldViewController, didInputText text: String)
}


class TextFieldViewController: GenericViewController<TextFieldViewModel, TextFieldRootView>, UITextFieldDelegate {
    weak var delegate: TextFieldViewControllerDelegate?

    override func viewDidLoad() {
        rootView.textField.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldViewController(self, didInputText: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
