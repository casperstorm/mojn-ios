//
//  PseudosViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 04/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Siesta
import UIKit

class HeaderItemViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 100
    }
}

class AddItemViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 88
    }
}

class CountItemViewModel: CellViewModelSizable {
    var count: Int?
    
    func height() -> CGFloat {
        return 159
    }
}

class PseudoItemViewModel: CellViewModelSizable {
    var description: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var emoji: String?
    
    func name() -> String? {
        return firstName
    }
    
    func height() -> CGFloat {
        return 220
    }
}

protocol PseudosViewModelDelegate: class {
    func pseudosViewModel(_ viewModel: PseudosViewModel, didChangeData data: [[ViewModel]])
}

class PseudosViewModel: ViewModel {
    weak var delegate: PseudosViewModelDelegate?
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.pseudosViewModel(self, didChangeData: cellViewModels)
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
        
        let headerViewModel = HeaderItemViewModel()
        let addViewModel = AddItemViewModel()
        let countViewModel = CountItemViewModel()
        countViewModel.count = pseudos.count
        
        let data = pseudos.map { (pseudo) -> PseudoItemViewModel in
            let vm = PseudoItemViewModel()
            vm.description = pseudo.description
            vm.firstName = pseudo.firstName
            vm.lastName = pseudo.lastName
            vm.phoneNumber = pseudo.phoneNumber
            vm.emoji = pseudo.emoji
            
            return vm
        }
        
        let add = [addViewModel]
        let count = [countViewModel]
        let header = [headerViewModel]
        
        self.cellViewModels = [header, add, count, data]
    }
}
