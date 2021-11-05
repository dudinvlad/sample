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
        private var alarmIsOn = false

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

        private lazy var alarmTimeLabel: UILabel = build {
            $0.font = Style.Font.titleBold
            $0.isHidden = true
        }

        private lazy var startAction: UIAction = .init { [weak self] _ in
            guard let self = self else { return }
            if !self.alarmIsOn {
                self.output.fireAlarm()
                self.output.showChooseMusic()
            } else {
                self.output.stoplarm()
            }

            self.configureUI()
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

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(logYes(note:)),
                name: NotificationName.alarmWillPresent.notification,
                object: nil
            )
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
        view.addSubview(alarmTimeLabel)

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

        alarmTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
    }

    func configureUI(with time: String? = nil) {
        alarmIsOn.toggle()

        alarmPicker.isHidden = alarmIsOn
        alarmTimeLabel.isHidden = !alarmIsOn
        startButton.setTitle(alarmIsOn == true ? "Stop" : "Start", for: .normal)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        guard let _ = time else {
            alarmTimeLabel.text = dateFormatter.string(from: alarmPicker.date)
            return
        }

        alarmTimeLabel.text = time
    }

    @objc func logYes(note: NSNotification) {
        configureUI()
    }

}

extension View: Module.ViewInput {
    func getSelectedTime() -> Date {
        return alarmPicker.date
    }

    func alarmIsOnConfigure(with time: String) {
        configureUI(with: time)
    }
}
