//
//  WelcomeViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

private typealias Module = WelcomeModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Variables

        private lazy var welcomeLabel: UILabel = {
            let label: UILabel = .init()

            label.font = .systemFont(ofSize: 20)
            label.text = "Music Alarm Clock for Spotify"

            return label
        }()

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            super.init(nibName: nil, bundle: nil)

        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
            performNextAction()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            output?.didAppear()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            output?.didDisappear()
        }
    }
}

private extension View {
    func initialSetup() {
        view.backgroundColor = Style.Color.main
        view.addSubview(welcomeLabel)

        welcomeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func performNextAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.output.requestMainAuthFlow()
        }
    }
}

extension View: Module.ViewInput { }
