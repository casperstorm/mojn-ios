//
//  PseudoCollectionViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Layoutless

class PseudoCollectionViewController: GenericViewController<PseudoCollectionViewModel, PseudoCollectionRootView>, UICollectionViewDelegate, UICollectionViewDataSource {
    let configurator = PseudoCollectionViewCellConfigurator()
    override func viewDidLoad() {
        self.viewModel.delegate = self
        self.rootView.collectionView.delegate = self
        self.rootView.collectionView.dataSource = self
        
        if let layout = rootView.collectionView.collectionViewLayout as? PseudoCollectionLayout {
            layout.delegate = self
        }
        
        self.viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if let vm = cellViewModel as? PseudoCollectionDefaultCellViewModel {
            guard let pseudo = vm.pseudo else { return }
            let vc = ConversationTableViewController(viewModel: ConversationTableViewModel(pseudo: pseudo))
            show(vc, sender: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        
        if let vm = cellViewModel as? PseudoCollectionHeaderCellViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCollectionHeaderCell.identifier, for: indexPath) as! PseudoCollectionHeaderCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        if let vm = cellViewModel as? PseudoCollectionAddCellViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCollectionAddCell.identifier, for: indexPath) as! PseudoCollectionAddCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        if let vm = cellViewModel as? PseudoCollectionCountCellViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCollectionCountCell.identifier, for: indexPath) as! PseudoCollectionCountCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        if let vm = cellViewModel as? PseudoCollectionDefaultCellViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCollectionDefaultCell.identifier, for: indexPath) as! PseudoCollectionDefaultCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        if let vm = cellViewModel as? PseudoCollectionEmptyCellViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCollectionEmptyCell.identifier, for: indexPath) as! PseudoCollectionEmptyCell
            configurator.configure(cell, with: vm)
            return cell
        }
        
        
        
        return UICollectionViewCell()
    }
}

// MARK: - PseudosViewModelDelegate

extension PseudoCollectionViewController: PseudoCollectionViewModelDelegate {
    func pseudoCollectionViewModel(_ viewModel: PseudoCollectionViewModel, didChangeData data: [[ViewModel]]) {
        rootView.collectionView.reloadData()
    }
}

extension PseudoCollectionViewController: PseudoCollectionLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat {
        let section = viewModel.cellViewModels[indexPath.section]
        let item = section[indexPath.row]
        
        if let item = item as? CellViewModelSizable {
            return item.height()
        }
        
        return 0
    }
}
