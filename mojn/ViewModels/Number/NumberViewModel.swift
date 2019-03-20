//
//  NumberViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class NumberDefaultCellViewModel: CellViewModelSizable {
    var number: Number?
    var pseudo: Pseudo?

    func height() -> CGFloat {
        return 75
    }
}

protocol NumberViewModelDelegate: class {
    func numberViewModel(_ viewModel: NumberViewModel, didChangeData data: [[ViewModel]])
}

class NumberViewModel: ViewModel {
    weak var delegate: NumberViewModelDelegate?
    var numberResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            numberResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.numberViewModel(self, didChangeData: cellViewModels)
        }
    }
}

extension NumberViewModel {
    func loadData() {
        numberResource = MojnAPI.sharedInstance.numbers()
    }
}

extension NumberViewModel: ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let numbers: [Number] = resource.typedContent() else { return }
        
        let database = Database()
        let pseudos = database.queryPseudos()

        let data = numbers.map{ (number) -> NumberDefaultCellViewModel in
            let vm = NumberDefaultCellViewModel()
            vm.number = number
            vm.pseudo = pseudos?.first(where: { $0.phoneNumber == number.number })
            return vm
        }
        
        
        self.cellViewModels = [data]
    }
}
