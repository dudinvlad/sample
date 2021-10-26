//
//  BaseViewController.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    // MARK: - Public

    func navigationBarClear() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    func set(title: String) {
        self.title = title
    }

    func addBackButton() {
        let barItem: UIBarButtonItem = .init(image: Style.Image.backArrow?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popViewController))

        guard self.navigationItem.leftBarButtonItem != nil else {
            self.navigationItem.leftBarButtonItem = barItem
            return
        }

        self.navigationItem.leftBarButtonItems?.append(barItem)
    }

    // MARK: - Private

    private func initialSetup() {
        view.backgroundColor = Style.Color.main
        
        navigationBarClear()
        addBackButton()
    }

    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
