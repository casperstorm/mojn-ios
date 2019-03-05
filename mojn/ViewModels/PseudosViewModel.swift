//
//  PseudosViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 04/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Siesta

protocol PseudosViewModelDelegate: class {
    func pseudosViewModel(_ viewModel: PseudosViewModel, didChangeData data: [Pseudo])
}

class PseudosViewModel: ViewModel {
    weak var delegate: PseudosViewModelDelegate?
    var data: [Pseudo] = [] {
        didSet {
            delegate?.pseudosViewModel(self, didChangeData: data)
        }
    }
    var pseudoResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            pseudoResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    
    func loadData() {
        pseudoResource = MojnAPI.sharedInstance.pseudos()
    }
}

extension PseudosViewModel: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let pseudos: [Pseudo] = resource.typedContent() else { return }
        self.data = pseudos
    }
}
