//
//  PseudosViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Layoutless
import Siesta
import SiestaUI

class PseudosViewController: ViewController {
    var pseudoResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            pseudoResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(PseudoCell.self, forCellWithReuseIdentifier: PseudoCell.identifier)
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .white
        return cv
    }()
    
    private var statusOverlay = ResourceStatusOverlay()
    private let refreshControl = UIRefreshControl()
    var data: [Pseudo] = []
    
    override var subviewsLayout: AnyLayout {
        return View()
            .addingLayout(
                collectionView.fillingParent()
            ).addingLayout(
                statusOverlay.fillingParent()
            ).fillingParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.refreshControl = self.refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func fetchData() {
        self.pseudoResource = MojnAPI.sharedInstance.pseudos()
    }
    
    @objc func refreshData() {
        self.pseudoResource?.load()
    }
}

extension PseudosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PseudoCell.identifier, for: indexPath) as! PseudoCell
        let data = self.data[indexPath.item]
        
        cell.titleLabel.text = data.description
        cell.nameLabel.text = data.firstName + " " + data.lastName
        cell.phoneLabel.text = data.phoneNumber
        return cell
    }
}

extension PseudosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension PseudosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}

extension PseudosViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let pseudos: [Pseudo] = resource.typedContent() else { return }
        
        self.data = pseudos
        self.collectionView.reloadData()
        self.collectionView.refreshControl?.endRefreshing()
    }
}
