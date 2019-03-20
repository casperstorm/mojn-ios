//
//  NumberRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class NumberRootView: View, RootView {
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.apply(Stylesheet.tableView)
        return tv
    }()
    
    override public var subviewsLayout: AnyLayout {
        return tableView.fillingParent()
    }
}


extension NumberRootView {
    enum Stylesheet {
        static let tableView = Style<UITableView> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
            $0.separatorStyle = .none
            $0.register(NumberDefaultCell.self, forCellReuseIdentifier: NumberDefaultCell.identifier)
        }
    }
}
