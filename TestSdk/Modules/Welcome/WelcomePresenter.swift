//
//  WelcomePresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = WelcomeModule
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
    func requestMainAuthFlow() {
        router.showMainAuthFlow()
    }
}

extension Presenter: Module.InteractorOutput { }
