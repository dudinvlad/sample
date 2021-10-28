//
//  MainFlowViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = MainFlowModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UITabBarController, UITabBarControllerDelegate {
        // MARK: - Dependencies

        var output: ViewOutput!

        private let viewControllerDataSource: [UIViewController]

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init(_ tabs: [UIViewController]) {
            self.viewControllerDataSource = tabs
            super.init(nibName: nil, bundle: nil)
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            output?.didAppear()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            output?.didDisappear()
        }

        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
    }
}

private extension View {
    func initialSetup() {
        delegate = self
        setupViewController()
    }

    func setupViewController() {
        viewControllerDataSource.enumerated().forEach { $1.tabBarItem = createTabbarItem(for: $0) }
        viewControllers = viewControllerDataSource
    }

    func createTabbarItem(for indexPath: Int) -> UITabBarItem {
        switch indexPath {
        case .zero:
            return UITabBarItem(title: "Alarm", image: UIImage(systemName: "alarm"), selectedImage: UIImage(systemName: "alarm.fill"))
        default:
            return UITabBarItem(title: "About us", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        }
    }
}

extension View: Module.ViewInput { }
