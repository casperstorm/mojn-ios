//
//  MessageViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class MessageViewController: GenericViewController<MessageViewModel, MessageRootView>, UITableViewDelegate, UITableViewDataSource {
    let configurator = MessageViewCellConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
                
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.tintColor(color: UIColor(hexString: "#310c4d"))
        self.title = "messages"
        
        viewModel.loadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        guard let cvm = cellViewModel as? MessageTableViewMessageItem else { return }
        guard let message = cvm.message else { return }
        
        let pseudo = viewModel.pseudo
        let recipient = message.recipient
        let vm = MessageDetailViewModel(pseudo: pseudo, recipient: recipient)
        let vc = MessageDetailViewController(viewModel: vm)
        show(vc, sender: self)
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
        
        if let vm = cellViewModel as? MessageTableViewMessageItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageDefaultCell.identifier, for: indexPath) as! MessageDefaultCell
            configurator.configure(cell, with: vm)
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

extension MessageViewController: MessageViewModelDelegate {
    func MessageViewModel(_ viewModel: MessageViewModel, didChangeData data: [[ViewModel]]) {
        rootView.tableView.reloadData()
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}
