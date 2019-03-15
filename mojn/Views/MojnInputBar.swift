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
        backgroundView.backgroundColor = .white
        
        inputTextView.placeholderTextColor = UIColor(hexString: "#310c4d", alpha: 0.5)
        inputTextView.backgroundColor = .white
        inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 10)
        inputTextView.font = UIFont(name: "OverpassMono-Light", size: 17)!
        inputTextView.textColor = UIColor(hexString: "#310c4d")
        
        sendButton.setSize(CGSize(width: 52, height: 36), animated: false)
    }
}
