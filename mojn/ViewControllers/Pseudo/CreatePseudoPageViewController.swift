//
//  CreatePseudoPageViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 21/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class CreatePseudoPageViewController: UIPageViewController {
    enum Steps {
        case number, emoji, title, name
    }
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 50))
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        return pageControl
    }()
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withStep: .number),
            self.getViewController(withStep: .title)
        ]
    }()
    
    let viewModel: CreatePseudoPageViewModel
    let numberViewController: NumberViewController
    let titleViewController: TextFieldViewController

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        self.viewModel = CreatePseudoPageViewModel()
        
        self.numberViewController = NumberViewController(viewModel: NumberViewModel())
        self.titleViewController = TextFieldViewController(viewModel: TextFieldViewModel())
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.numberViewController.delegate = self
        
        self.setupStyling()
        
        self.pageControl.numberOfPages = pages.count
        self.view.addSubview(pageControl)
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func getViewController(withStep step: Steps) -> UIViewController
    {
        switch step {
        case .number:
            return self.numberViewController
        case .title:
            return self.titleViewController
        default:
            return UIViewController()
        }
    }
    
    func nextViewController() -> UIViewController? {
        guard let currentVC = viewControllers?.first else { return nil }
        guard let viewControllerIndex = pages.index(of: currentVC) else { return nil }

        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
    
    func previousViewController() -> UIViewController? {
        guard let currentVC = viewControllers?.first else { return nil }
        guard let viewControllerIndex = pages.index(of: currentVC) else { return nil }

        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
}

extension CreatePseudoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return previousViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController()
    }
}

extension CreatePseudoPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        print(pageContentViewController)
        self.pageControl.currentPage = pages.index(of: pageContentViewController)!
    }
}

extension CreatePseudoPageViewController: NumberViewControllerDelegate {
    func numberViewController(_ viewController: NumberViewController, didSelectNumber number: Number) {
        guard let nextVC = nextViewController() else { return }
        setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        
        viewModel.pseudoPhoneNumber(number: number)
    }
}

extension CreatePseudoPageViewController {
    func setupStyling() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.tintColor(color: UIColor(hexString: "#f98b74"))
        self.view.backgroundColor = UIColor(hexString: "#f98b74")
        
        self.title = "Create Pseudo"
    }
}
