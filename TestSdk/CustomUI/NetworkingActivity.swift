//
//  NetworkingActivity.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 29.10.2021.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

final class NetworkingActivity {
    private static let zeroViewController: UIViewController = .init()
    private static let activity: NVActivityIndicatorView = .init(frame: .zero)
    private static let zeroView: UIView = build {
        $0.backgroundColor = Style.Color.nightBlue
        $0.alpha = 0.2
    }

    private static var isPresented: Bool = false

    static func show(viewController: UIViewController, color: UIColor, type: NVActivityIndicatorType) {
        guard
            let navigationController = viewController.navigationController,
            isPresented == false
        else { return }

        activity.color = color
        activity.type = type

        zeroViewController.modalPresentationStyle = .overFullScreen
        zeroViewController.view.addSubview(zeroView)
        zeroViewController.view.addSubview(activity)

        zeroView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

        activity.snp.makeConstraints { make in
            make.width.height.equalTo(zeroViewController.view.frame.width * 0.2)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-zeroViewController.view.frame.width * 0.2 )
        }

        activity.startAnimating()

        navigationController.present(zeroViewController, animated: false) {
            isPresented = true
        }
    }

    static func hide() {
        guard isPresented == true else { return }

        activity.stopAnimating()
        zeroViewController.dismiss(animated: false) {
            isPresented = false
        }
    }
}

