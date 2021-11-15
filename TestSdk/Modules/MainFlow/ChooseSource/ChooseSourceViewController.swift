//
//  ChooseSourceViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Variables
    
        private lazy var containerStack: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack
        }

        private lazy var spotifyContainerStack: UIStackView = build {
            $0 <~ Style.Stack.smallSpaceHorizontalStack
            $0.distribution = .equalCentering
            $0.alignment = .center
        }

        private lazy var offlineContainerStack: UIStackView = build {
            $0 <~ Style.Stack.smallSpaceHorizontalStack
            $0.distribution = .equalCentering
            $0.alignment = .center
        }

        private lazy var titleContainerStack: UIStackView = build {
            $0 <~ Style.Stack.smallSpaceVerticalStack
        }

        private lazy var offlineTitleContainerStack: UIStackView = build {
            $0 <~ Style.Stack.smallSpaceVerticalStack
        }

        private lazy var logoImageView: UIImageView = build {
            $0.image = Style.Image.spotify
        }

        private lazy var offlineLogoImageView: UIImageView = build {
            $0.image = Style.Image.offlineMusic
        }

        private lazy var titleLabel: UILabel = build {
            $0 <~ Style.Label.titleLabel
            $0.text = "Spotify"
        }

        private lazy var offlineTitleLabel: UILabel = build {
            $0 <~ Style.Label.titleLabel
            $0.text = "Default songs"
        }

        private lazy var descriptionLabel: UILabel = build {
            $0 <~ Style.Label.descriptionLabel
            $0.text = "Online · Premium required"
        }

        private lazy var offlineDescriptionLabel: UILabel = build {
            $0 <~ Style.Label.descriptionLabel
            $0.text = "Default · songs"
        }

        private lazy var spotifyButton: UIButton = build {
            $0.backgroundColor = .clear
            $0.addAction(spotifyAction, for: .touchUpInside)
        }

        private lazy var offlineButton: UIButton = build {
            $0.backgroundColor = .clear
            $0.addAction(offlineAction, for: .touchUpInside)
        }

        private lazy var spotifyAction: UIAction = .init { _ in
            self.output.requestSpotifyConnect()
        }

        private lazy var offlineAction: UIAction = .init { _ in
            self.output.showOfflineMusic()
        }

        private lazy var spacerView: UIView = .init()
        private lazy var defaultSpacerView: UIView = .init()
        private lazy var containerSpacerView: UIView = .init()

        private lazy var arrowImageView: UIImageView = build {
            $0.image = Style.Image.chevronRight
            $0.tintColor = Style.Color.main
        }
        private lazy var offlineArrowImageView: UIImageView = build {
            $0.image = Style.Image.chevronRight
            $0.tintColor = Style.Color.main
        }

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
    private func initialSetup() {
        view.backgroundColor = Style.Color.black
        title = "Choose Source"
        view.addSubview(containerStack)
        view.addSubview(spotifyButton)
        view.addSubview(offlineButton)

        containerStack.addArrangedSubview(spotifyContainerStack)
        containerStack.addArrangedSubview(offlineContainerStack)
        containerStack.addArrangedSubview(containerSpacerView)

        containerStack.setCustomSpacing(20, after: spotifyContainerStack)

        spotifyContainerStack.addArrangedSubview(logoImageView)
        spotifyContainerStack.addArrangedSubview(titleContainerStack)
        spotifyContainerStack.addArrangedSubview(spacerView)
        spotifyContainerStack.addArrangedSubview(arrowImageView)

        offlineContainerStack.addArrangedSubview(offlineLogoImageView)
        offlineContainerStack.addArrangedSubview(offlineTitleContainerStack)
        offlineContainerStack.addArrangedSubview(defaultSpacerView)
        offlineContainerStack.addArrangedSubview(offlineArrowImageView)

        spotifyContainerStack.setCustomSpacing(10, after: logoImageView)
//        offlineContainerStack.setCustomSpacing(10, after: offlineLogoImageView)

        titleContainerStack.addArrangedSubview(titleLabel)
        titleContainerStack.addArrangedSubview(descriptionLabel)

        offlineTitleContainerStack.addArrangedSubview(offlineTitleLabel)
        offlineTitleContainerStack.addArrangedSubview(offlineDescriptionLabel)

        containerStack.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }

        spotifyButton.snp.makeConstraints { make in
            make.edges.equalTo(spotifyContainerStack.snp.edges)
        }
        offlineButton.snp.makeConstraints { make in
            make.edges.equalTo(offlineContainerStack.snp.edges)
        }

        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        offlineLogoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        spotifyContainerStack.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        offlineTitleContainerStack.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        arrowImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        offlineArrowImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
}

extension View: Module.ViewInput {}
