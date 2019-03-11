//
//  PseudosViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Layoutless

class PseudosViewController: GenericViewController<PseudosViewModel, PseudosRootView>, UICollectionViewDelegate, UICollectionViewDataSource {
    let configurator = PseudoCollectionViewCellConfigurator()
    override func viewDidLoad() {
        self.viewModel.delegate = self
        self.rootView.collectionView.delegate = self
        self.rootView.collectionView.dataSource = self
        
        if let layout = rootView.collectionView.collectionViewLayout as? PseudoLayout {
            layout.delegate = self
        }
        
        self.viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.cellViewModels[indexPath.section]
        let cellViewModel = section[indexPath.row]
        

        if let cellViewModel = cellViewModel as? PseudoItemPseudosViewModel {
            guard let pseudo = cellViewModel.pseudo else { return }
            let vc = MessageListViewController(viewModel: MessageListViewModel(pseudo: pseudo))
            navigationController?.present(vc, animated: true, completion: nil)
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
        
        if cellViewModel is HeaderItemPseudosViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoHeaderCell.identifier, for: indexPath) as! PseudoHeaderCell
            if let cellViewModel = cellViewModel as? HeaderItemPseudosViewModel {
                configurator.configure(cell, with: cellViewModel)
            }
            return cell
        }
        
        
        if cellViewModel is AddItemPseudosViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoAddCell.identifier, for: indexPath) as! PseudoAddCell
            if let cellViewModel = cellViewModel as? AddItemPseudosViewModel {
                configurator.configure(cell, with: cellViewModel)
            }
            return cell
        }
        
        if cellViewModel is CountItemPseudosViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCountCell.identifier, for: indexPath) as! PseudoCountCell
            if let cellViewModel = cellViewModel as? CountItemPseudosViewModel {
                configurator.configure(cell, with: cellViewModel)
            }
            return cell
        }
        
        if cellViewModel is PseudoItemPseudosViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCell.identifier, for: indexPath) as! PseudoCell
            if let cellViewModel = cellViewModel as? PseudoItemPseudosViewModel {
                configurator.configure(cell, with: cellViewModel)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - PseudosViewModelDelegate

extension PseudosViewController: PseudosViewModelDelegate {
    func pseudosViewModel(_ viewModel: PseudosViewModel, didChangeData data: [[ViewModel]]) {
        rootView.collectionView.reloadData()
    }
}

extension PseudosViewController: PseudoLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat {
        let section = viewModel.cellViewModels[indexPath.section]
        let item = section[indexPath.row]
        
        if let item = item as? CellViewModelSizable {
            return item.height()
        }
        
        return 0
    }
}
