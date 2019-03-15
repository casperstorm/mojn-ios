//
//  MessageRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless
import Siesta

public class MessageRootView: View, RootView {
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.apply(Stylesheet.tableView)
        return tv
    }()
    
    override public var subviewsLayout: AnyLayout {
        return tableView.fillingParent()
    }
}

public extension MessageRootView {
    enum Stylesheet {
        static let tableView = Style<UITableView> {
            $0.backgroundColor = UIColor(hexString: "#310c4d")
            $0.separatorStyle = .none
            $0.register(MessageDefaultCell.self, forCellReuseIdentifier: MessageDefaultCell.identifier)
        }
    }
}
