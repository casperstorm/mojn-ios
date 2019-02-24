//
//  ViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 19/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Siesta
import Layoutless

class RootViewController: UIViewController {
    var button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    var userResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            userResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTempButton()
    }
    
    func addTempButton() {
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("hello world", for: .normal)
        button.backgroundColor = .red
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton) {
        MojnAPI.sharedInstance.login(username: "casper", password: "casper")
            .onSuccess { _ in
                self.button.backgroundColor = .green
                self.userResource = MojnAPI.sharedInstance.user()
        }
    }
}

// MARK: - ResourceObserver
extension RootViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let user: User = resource.typedContent() else { return }
        print("hello " + user.username)
    }
}

