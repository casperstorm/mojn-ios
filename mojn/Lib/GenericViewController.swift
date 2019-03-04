//
//  MJNViewController.swift
//  mojn
//
//  Created by Kasper Kronborg on 27/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

public class GenericViewController<M: ViewModel, V: RootView>: UIViewController where V: UIView
{
    public let viewModel: M
    
    public var rootView: V! { return self.view as? V }
    
    required public init(viewModel: M) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        self.view = V()
    }
}
