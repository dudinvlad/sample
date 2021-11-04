//
//  ChooseMusicViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController {
        // MARK: - Dependencies

        // MARK: - Variables

        private lazy var containerStack: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack
            $0.spacing = 20
        }

        private lazy var titleLabel: UILabel = build {
            $0 <~ Style.Label.titleLabel
            $0.text = "Get into it!"
        }

        private lazy var descriptionLabel: UILabel = build {
            $0 <~ Style.Label.descriptionLabel
            $0.text = "Tap the button below to start adding your favorite music"
        }

        private lazy var spacerView: UIView = .init()

        private lazy var spotifyButton: UIButton = build {
            $0 <~ Style.Button.spotifyButton
            $0.setTitle("Add new", for: .normal)
            $0.setImage(Style.Image.plusFilled, for: .normal)
            $0.contentHorizontalAlignment = .leading
            $0.titleEdgeInsets.left = 20
            $0.imageEdgeInsets.left = 10
            $0.backgroundColor = .systemGray6
            $0.imageView?.tintColor = UIColor.systemGreen
            $0.addAction(spotifyAction, for: .touchUpInside)
        }

        private lazy var spotifyAction: UIAction = .init { _ in
            self.output.showChooseSource()
        }

        var output: ViewOutput!

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
        view.backgroundColor = Style.Color.black
        view.addSubview(containerStack)

        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(descriptionLabel)
        containerStack.addArrangedSubview(spotifyButton)
        containerStack.addArrangedSubview(spacerView)

        containerStack.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }

        spotifyButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        title = "Choose Music"
    }
}

extension View: Module.ViewInput { }
