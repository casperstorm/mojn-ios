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
        case number, emoji, title, name, summary
    }
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width, height: 50))
        pageControl.currentPage = 0
        pageControl.tintColor =  UIColor(hexString: "#472761")
        pageControl.pageIndicatorTintColor = UIColor(hexString: "#ffffff")
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#472761")
        return pageControl
    }()
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withStep: .title),
            self.getViewController(withStep: .name),
            self.getViewController(withStep: .number),
            self.getViewController(withStep: .emoji),
            self.getViewController(withStep: .summary)
        ]
    }()
    
    let viewModel: CreatePseudoPageViewModel
    let numberViewController: NumberViewController
    let titleViewController: TextFieldViewController
    let nameViewController: TextFieldViewController
    let emojiViewController: TextFieldViewController
    let summaryViewController: PseudoTemplateViewController

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        self.viewModel = CreatePseudoPageViewModel()
        
        self.numberViewController = NumberViewController(viewModel: NumberViewModel())
        self.titleViewController = TextFieldViewController(viewModel: TextFieldViewModel())
        self.nameViewController = TextFieldViewController(viewModel: TextFieldViewModel())
        self.emojiViewController = TextFieldViewController(viewModel: TextFieldViewModel())
        self.summaryViewController = PseudoTemplateViewController(viewModel: PseudoTemplateViewModel())
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        numberViewController.delegate = self
        
        titleViewController.delegate = self
        titleViewController.rootView.textField.placeholder = "Title"
        titleViewController.rootView.textLabel.text = "Please input the title of the pseudo\nEg. Dating, Shopping etc."
        
        nameViewController.delegate = self
        nameViewController.rootView.textField.placeholder = "Name"
        nameViewController.rootView.textLabel.text = "Please input the name of the pseudo\nEg. John Doe, Alex Jones etc"
        
        emojiViewController.delegate = self
        emojiViewController.rootView.textField.placeholder = "Emoji"
        emojiViewController.rootView.textLabel.text = "Please input a emoji for your pseudo\nEg. 🏡, 🔥 etc"
        
        summaryViewController.rootView.button.addTarget(self, action: #selector(createPseudo), for: .touchUpInside)
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonPressed))
        navigationItem.leftBarButtonItem = closeButton
        
        setupStyling()
        
        pageControl.numberOfPages = pages.count
        view.addSubview(pageControl)
        
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
        case .name:
            return self.nameViewController
        case .emoji:
            return self.emojiViewController
        case .summary:
            return self.summaryViewController
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
    
    func setPseudoTemplate(pseudo: Pseudo) {
        summaryViewController.rootView.nameLabel.text = pseudo.name
        summaryViewController.rootView.titleLabel.text = pseudo.title
        summaryViewController.rootView.emojiLabel.text = pseudo.emoji
        summaryViewController.rootView.phoneLabel.text = pseudo.phoneNumber
    }
    
    @objc func createPseudo() {
        let pseudo = viewModel.build()
        
        let database = Database()
        database.writePseudo(pseudo)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
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

extension CreatePseudoPageViewController: TextFieldViewControllerDelegate {
    func textFieldViewController(_ viewController: TextFieldViewController, didInputText text: String) {
        
        guard let currentVC = viewControllers?.first else { return }
        
        switch currentVC {
        case titleViewController:
            viewModel.pseudoTitle(title: text)
        case nameViewController:
            viewModel.pseudoName(name: text)
        case emojiViewController:
            viewModel.pseudoEmoji(emoji: text)
        default: break
        }
        
        let pseudo = viewModel.build()
        setPseudoTemplate(pseudo: pseudo)

        guard let nextVC = nextViewController() else { return }
        setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
}


extension CreatePseudoPageViewController {
    func setupStyling() {
        UINavigationBar.tintColor(color: UIColor(hexString: "#f98b74"))
        self.view.backgroundColor = UIColor(hexString: "#f98b74")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = nil
    }
}
