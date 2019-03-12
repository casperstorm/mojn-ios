//
//  MessageListViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class MessageListViewController: GenericViewController<MessageListViewModel, MessageListRootView>, UITableViewDelegate, UITableViewDataSource {
    let configurator = MessageListTableViewCellConfigurator()

    override func viewDidLoad() {
        viewModel.delegate = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        viewModel.cellViewModels = [[MessageItemMessageListViewModel(), MessageItemMessageListViewModel(), MessageItemMessageListViewModel()]]
        rootView.headerView.title = "messages"
        rootView.headerView.emoji = viewModel.pseudo.emoji
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
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
        
        if cellViewModel is MessageItemMessageListViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageListDefaultCell.identifier, for: indexPath) as! MessageListDefaultCell
            if let cellViewModel = cellViewModel as? MessageItemMessageListViewModel {
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

extension MessageListViewController: MessageListViewModelDelegate {
    func messageListViewModel(_ viewModel: MessageListViewModel, didChangeData data: [[ViewModel]]) {
        print("called!")
    }
}

