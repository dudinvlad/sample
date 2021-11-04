//
//  AlarmViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit

private typealias Module = AlarmModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: BaseViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Variables

        private lazy var containerStackView: UIStackView = build {
            $0 <~ Style.Stack.smallSpaceVerticalStack
        }

        private lazy var alarmPicker: UIDatePicker = build {
            $0.datePickerMode = .time
            $0.preferredDatePickerStyle = .wheels
        }

        private lazy var infoLabel: UILabel = build {
            $0 <~ Style.Label.infoLabel
            $0.text = "Wake up with your\nfavourite music"
        }

        private lazy var startButton: UIButton = build {
            $0 <~ Style.Button.authConfirmButton
            $0.setTitle("Start", for: .normal)
            $0.addAction(startAction, for: .touchUpInside)
        }

        private lazy var startAction: UIAction = .init { _ in
            self.output.showChooseMusic()
            self.output.fireAlarm()
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
        view.addSubview(containerStackView)

        containerStackView.addArrangedSubview(alarmPicker)
        containerStackView.addArrangedSubview(infoLabel)
        containerStackView.addArrangedSubview(startButton)

        containerStackView.setCustomSpacing(30, after: infoLabel)

        containerStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        startButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
}

extension View: Module.ViewInput {
    func getSelectedTime() -> Date {
        return alarmPicker.date
    }
}
