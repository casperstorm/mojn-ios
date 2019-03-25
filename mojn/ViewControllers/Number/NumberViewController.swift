//
//  NumberViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

protocol NumberViewControllerDelegate: class {
    func numberViewController(_ viewController: NumberViewController, didSelectNumber number: Number)
}

class NumberViewController: GenericViewController<NumberViewModel, NumberRootView>, UITableViewDelegate, UITableViewDataSource {
    let configurator = NumberViewCellConfigurator()
    weak var delegate: NumberViewControllerDelegate?
    override func viewDidLoad() {
        self.viewModel.delegate = self
        
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
        
        viewModel.loadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if let vm = cellViewModel as? NumberDefaultCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: NumberDefaultCell.identifier, for: indexPath) as! NumberDefaultCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if let vm = cellViewModel as? NumberDefaultCellViewModel {
            return vm.height()
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if let vm = cellViewModel as? NumberDefaultCellViewModel, let number = vm.number {
            delegate?.numberViewController(self, didSelectNumber: number)
        }
    }
}

extension NumberViewController: NumberViewModelDelegate {
    func numberViewModel(_ viewModel: NumberViewModel, didChangeData data: [[ViewModel]]) {
        rootView.tableView.reloadData()
    }
}
