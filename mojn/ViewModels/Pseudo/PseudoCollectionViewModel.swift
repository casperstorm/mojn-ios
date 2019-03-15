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

class PseudoCollectionHeaderCellViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 184
    }
}

class PseudoCollectionAddCellViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 88
    }
}

class PseudoCollectionCountCellViewModel: CellViewModelSizable {
    var count: Int?
    
    func height() -> CGFloat {
        return 159
    }
}

class PseudoCollectionDefaultCellViewModel: CellViewModelSizable {
    var pseudo: Pseudo?
    
    func name() -> String? {
        return pseudo?.firstName
    }
    
    func height() -> CGFloat {
        return 220
    }
}

class PseudoCollectionEmptyCellViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 220
    }
}

protocol PseudoCollectionViewModelDelegate: class {
    func pseudoCollectionViewModel(_ viewModel: PseudoCollectionViewModel, didChangeData data: [[ViewModel]])
}

class PseudoCollectionViewModel: ViewModel {
    weak var delegate: PseudoCollectionViewModelDelegate?
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.pseudoCollectionViewModel(self, didChangeData: cellViewModels)
        }
    }
}

extension PseudoCollectionViewModel {
    func loadData() {
        let database = Database()
        guard let pseudos = database.queryPseudos() else { return }
        
        let headerViewModel = PseudoCollectionHeaderCellViewModel()
        let addViewModel = PseudoCollectionAddCellViewModel()
        let countViewModel = PseudoCollectionCountCellViewModel()
        countViewModel.count = pseudos.count

        var data: [ViewModel] = []
        if (pseudos.count == 0) {
            data = [PseudoCollectionEmptyCellViewModel(),
                    PseudoCollectionEmptyCellViewModel(),
                    PseudoCollectionEmptyCellViewModel()]
        } else {
            data = pseudos.map { (pseudo) -> PseudoCollectionDefaultCellViewModel in
                let vm = PseudoCollectionDefaultCellViewModel()
                vm.pseudo = pseudo
                return vm
            }
        }
        
        let add = [addViewModel]
        let count = [countViewModel]
        let header = [headerViewModel]
        
        self.cellViewModels = [header, add, count, data]
    }
}
