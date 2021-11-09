//
//  AlarmViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit
import UserNotifications
import MediaPlayer

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
            $0.minimumDate = Date()
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

        private lazy var logoutButton: UIButton = build {
            $0 <~ Style.Button.authConfirmButton
            $0.setTitle("Logout", for: .normal)
            $0.addAction(logoutAction, for: .touchUpInside)
        }

        private lazy var logoutAction: UIAction = .init { _ in
            self.output.logout()
        }

        private lazy var startAction: UIAction = .init { [weak self] _ in
            guard let self = self else { return }
            if !self.alarmIsOn {
                self.output.fireAlarm()
                self.output.showChooseMusic()
                self.configureOnAlarm(with: self.getSelectedTIme())
            } else {
                self.output.stopAlarm()
                self.configureOffAlarm()
            }

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
            UNUserNotificationCenter.current().delegate = self
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            output.willAppear()
            alarmPicker.minimumDate = Date()
        }
    }
}

private extension View {
    func initialSetup() {
        view.addSubview(containerStackView)
        view.addSubview(alarmTimeLabel)
        view.addSubview(logoutButton)

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

        logoutButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 60, height: 30))
        }

        alarmTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
    }

    func checkForMusicLibraryAccess(andThen f:(()->())? = nil) {
        let status = MPMediaLibrary.authorizationStatus()
        switch status {
        case .authorized:
            f?()
        case .notDetermined:
            MPMediaLibrary.requestAuthorization() { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        f?()
                    }
                }
            }
        case .restricted:
            // do nothing
            break
        case .denied:
            break
            // do nothing, or beg the user to authorize us in Settings
//            let url = URL(string:UIApplication.openSettingsURLString)!
//            UIApplication.shared.open(url)
        @unknown default: fatalError()
        }
    }

    func configureOffAlarm() {
        alarmIsOn = false

        alarmPicker.isHidden = false
        alarmTimeLabel.isHidden = true
        startButton.setTitle("Start", for: .normal)
    }

    func getSelectedTIme() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        return dateFormatter.string(from: alarmPicker.date)
    }
}

extension View: Module.ViewInput {
    func getSelectedTime() -> Date {
        return alarmPicker.date
    }

    func configureOnAlarm(with time: String) {
        alarmIsOn = true
        alarmPicker.isHidden = true
        alarmTimeLabel.isHidden = false
        startButton.setTitle("Stop", for: .normal)
        alarmTimeLabel.text = "Alarm \(time)"
    }
}

extension View: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        configureOffAlarm()
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        configureOffAlarm()
    }
}
