//
//  ConversationTableViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class ConversationTableViewController: GenericViewController<ConversationTableViewModel, ConversationTableRootView>, UITableViewDelegate, UITableViewDataSource {
    let configurator = ConversationTableViewCellConfigurator()

    override func viewDidLoad() {
        viewModel.delegate = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        viewModel.cellViewModels = [[ConversationTableViewMessageItem(), ConversationTableViewMessageItem(), ConversationTableViewMessageItem()]]
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.tintColor(color: UIColor(hexString: "#310c4d"))
        self.title = "messages"
    }
        
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellViewModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if cellViewModel is ConversationTableViewMessageItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableDefaultCell.identifier, for: indexPath) as! ConversationTableDefaultCell
            if let cellViewModel = cellViewModel as? ConversationTableViewMessageItem {
                configurator.configure(cell, with: cellViewModel)
            }

            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.cellViewModels[indexPath.section]
        let item = section[indexPath.row]
        
        if let item = item as? CellViewModelSizable {
            return item.height()
        }
        
        return 0
    }
}

extension ConversationTableViewController: ConversationTableViewModelDelegate {
    func conversationTableViewModel(_ viewModel: ConversationTableViewModel, didChangeData data: [[ViewModel]]) {
        print("called!")
    }
}

