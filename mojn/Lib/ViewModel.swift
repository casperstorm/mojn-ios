//
//  MJNViewModel.swift
//  mojn
//
//  Created by Kasper Kronborg on 27/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewModel { }

public protocol CellViewModelSizable: ViewModel {
    func height() -> CGFloat
}
