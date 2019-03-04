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
    override func viewDidLoad() {
        self.viewModel.delegate = self
        self.rootView.collectionView.delegate = self
        self.rootView.collectionView.dataSource = self
        
        self.viewModel.loadData()
        

        
//        self.rootView.collectionView.refreshControl = self.refreshControl
//        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCell.identifier, for: indexPath) as! PseudoCell
//        let data = self.data[indexPath.item]
//
//        cell.titleLabel.text = data.description
//        cell.nameLabel.text = data.firstName + " " + data.lastName
//        cell.phoneLabel.text = data.phoneNumber
        return cell
    }
}

extension PseudosViewController: PseudosViewModelDelegate {
    func pseudosViewModel(_ viewModel: PseudosViewModel, didChangeData data: [Pseudo]) {
        print(data)
    }
}

//
//    private var statusOverlay = ResourceStatusOverlay()
//    private let refreshControl = UIRefreshControl()
//    var data: [Pseudo] = []
//
//    override var subviewsLayout: AnyLayout {
//        return View()
//            .addingLayout(
//                collectionView.fillingParent()
//            ).addingLayout(
//                statusOverlay.fillingParent()
//            ).fillingParent()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.fetchData()
//
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.refreshControl = self.refreshControl
//
//        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//    }
