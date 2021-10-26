//
//  MainAuthViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = MainAuthModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Variables

        private lazy var containerStackView: UIStackView = build {
            $0 <~ Style.Stack.DefaulStack(spacing: 25, axis: .vertical, alignment: .fill, distribution: .fill)
        }

        private lazy var loginButton: UIButton = build {
            $0 <~ Style.Button.authButton
            $0.addAction(loginButtonAction, for: .touchUpInside)
            $0.setTitle("Login", for: .normal)
        }

        private lazy var loginButtonAction: UIAction = .init { [weak self] _ in
            self?.output.requestLoginFlow()
        }

        private lazy var signUpButton: UIButton = build {
            $0 <~ Style.Button.authButton
            $0.addAction(signUpButtonAction, for: .touchUpInside)
            $0.setTitle("Signup", for: .normal)
        }

        private lazy var signUpButtonAction: UIAction = .init { [weak self] _ in
            self?.output.requestSignUpFlow()
        }

        private lazy var alarmImageView: UIImageView = build {
            $0.contentMode = .scaleAspectFit
            $0.image = .init(systemName: "alarm")
            $0.tintColor = Style.Color.nightBlue
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
    func initialSetup() {
        view.backgroundColor = Style.Color.main
        view.addSubview(containerStackView)

        containerStackView.addArrangedSubview(alarmImageView)
        containerStackView.addArrangedSubview(loginButton)
        containerStackView.addArrangedSubview(signUpButton)

        containerStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        alarmImageView.snp.makeConstraints { make in
            make.height.equalTo(128)
        }

        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}

extension View: Module.ViewInput { }
