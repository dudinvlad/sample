//
//  SubscriptionsPresenter.swift
//  TestSdk
//
//  Created macuser on 10/29/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SubscriptionsModule
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

extension Presenter: Module.ViewOutput { }

extension Presenter: Module.InteractorOutput { }
