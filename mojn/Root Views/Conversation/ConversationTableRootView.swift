//
//  ConversationTableRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless
import Siesta

public class ConversationTableRootView: View, RootView {
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.apply(Stylesheet.tableView)
        return tv
    }()
    lazy var headerView = ListHeaderView()
    
    override public var subviewsLayout: AnyLayout {
        return stack(.vertical)(
            headerView,
            tableView
            ).fillingParent()
    }
}

public extension ConversationTableRootView {
    enum Stylesheet {
        static let tableView = Style<UITableView> {
            $0.backgroundColor = UIColor(hexString: "#310c4d")
            $0.separatorStyle = .none
            $0.register(ConversationTableDefaultCell.self, forCellReuseIdentifier: ConversationTableDefaultCell.identifier)
        }
    }
}