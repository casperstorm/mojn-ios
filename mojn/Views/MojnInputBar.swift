//
//  MessageInputBar.swift
//  mojn
//
//  Created by Casper Rogild Storm on 26/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import MessageInputBar

class MojnInputBar: MessageInputBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundView.backgroundColor = UIColor(hexString: "#310c4d")
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 36, height: 36), animated: false)
        button.setImage(#imageLiteral(resourceName: "ic_plus").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.cornerRadius = 16.0
        inputTextView.layer.masksToBounds = true
        inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        setLeftStackViewWidthConstant(to: 36, animated: false)
        setStackViewItems([button], forStack: .left, animated: false)
        sendButton.setSize(CGSize(width: 52, height: 36), animated: false)
    }
}
