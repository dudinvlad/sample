//
//  BaseModuleProtocols.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 21.10.2021.
//

import UIKit
import Combine
import NVActivityIndicatorView

protocol BaseViewInput: AnyObject {
    func showNetworking(error text: String)
    func showNetworking(info text: String)
    func showActivity()
    func hideActivity()
}

protocol BaseViewOutput: AnyObject {
    func didLoad()
    func didAppear()
    func didDisappear()
    func willAppear()
    func willDisappear()
}

protocol BaseInteractorOutput: AnyObject {
    var controller: BaseViewInput? { get }

    func failureNetworking(text: String)
    func infoNetworking(text: String)
}

protocol BaseInteractor { }

extension BaseViewOutput {
    func didLoad() {}
    func didAppear() {}
    func didDisappear() {}
    func willAppear() {}
    func willDisappear() {}
}

extension BaseViewInput where Self: UIViewController {
    func showNetworking(error text: String) {
        UIApplication.shared.topMostViewController()?.showAlert(with: text)
    }

    func showNetworking(info text: String) {
        UIApplication.shared.topMostViewController()?.showAlert(with: text)
    }

    func showActivity() {
        NetworkingActivity.show(viewController: self, color: Style.Color.nightBlue, type: .ballSpinFadeLoader)
    }

    func hideActivity() {
        NetworkingActivity.hide()
    }
}

extension BaseInteractor {
}

extension BaseInteractorOutput {
    func failureNetworking(text: String) {
        controller?.hideActivity()
        controller?.showNetworking(error: text)
    }

    func infoNetworking(text: String) {
        controller?.hideActivity()
        controller?.showNetworking(info: text)
    }
}

