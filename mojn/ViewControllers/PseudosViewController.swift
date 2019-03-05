//
//  PseudosViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Layoutless

class PseudosViewController: GenericViewController<PseudosViewModel, PseudosRootView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        self.viewModel.delegate = self
        self.rootView.collectionView.delegate = self
        self.rootView.collectionView.dataSource = self
        
        self.viewModel.loadData()
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped!")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCell.identifier, for: indexPath) as! PseudoCell
        let data = viewModel.data[indexPath.item]

        cell.titleLabel.text = data.description
        cell.nameLabel.text = data.firstName + " " + data.lastName
        cell.emojiLabel.text = data.emoji
        cell.phoneLabel.text = data.phoneNumber
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset: CGFloat = 12 + 12 + 12
        return CGSize(width: (collectionView.bounds.width - inset) / 2, height: 220)
    }
}

// MARK: - PseudosViewModelDelegate

extension PseudosViewController: PseudosViewModelDelegate {
    func pseudosViewModel(_ viewModel: PseudosViewModel, didChangeData data: [Pseudo]) {
        rootView.collectionView.reloadData()
    }
}
