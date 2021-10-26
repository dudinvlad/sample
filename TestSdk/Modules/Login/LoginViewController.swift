//
//  LoginViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = LoginModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: BaseViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Variables

        private lazy var scrollView: UIScrollView = build {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }

        private lazy var containerStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack
            $0.spacing = 25
        }

        private lazy var emailFieldView: InputFieldView = build {
            $0.set(
                title: "Email",
                placeholder: "some@email.com",
                keyboardType: .emailAddress
            )
        }
        private lazy var passwordFieldView: InputFieldView = build {
            $0.set(
                title: "Password",
                placeholder: "••••••",
                isSecureTextEntry: true
            )
        }

        private lazy var submitButton: UIButton = build {
            $0 <~ Style.Button.authConfirmButton
            $0.setTitle("Submit", for: .normal)
            $0.addAction(submitAction, for: .touchUpInside)
        }

        private lazy var submitAction: UIAction = .init { _ in
            self.output.requestLogin(
                with: self.emailFieldView.currentText,
                password: self.passwordFieldView.currentText
            )
        }

        private lazy var spacerView: UIView = .init()

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

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            navigationController?.isNavigationBarHidden = false
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            navigationController?.isNavigationBarHidden = true
        }
    }
}

private extension View {
    func initialSetup() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)

        containerStackView.addArrangedSubview(emailFieldView)
        containerStackView.addArrangedSubview(passwordFieldView)
        containerStackView.addArrangedSubview(spacerView)
        containerStackView.addArrangedSubview(submitButton)

        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }

        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalToSuperview()
        }

        submitButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }

        setupNavigationBar()
    }

    func setupNavigationBar() {
        set(title: "Login")
    }
}

extension View: Module.ViewInput { }
