//
//  BaseTabBarController.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 28.10.2021.
//

import UIKit

class BaseTabBarController: UITabBarController {
    // MARK: - Variables

    // MARK: - Init

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Public

    // MARK: - Private
}
