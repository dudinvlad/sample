//
//  LoginPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = LoginModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        required init() { }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func requestLogin(with email: String, password: String) {
        interactor.login(email: email, password: password)
    }
}

extension Presenter: Module.InteractorOutput {
    func successLogin() {
        router.showMainFlow()
    }

    var controller: BaseViewInput? {
        view
    }
}
