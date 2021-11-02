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

        private let purchaseManager: PurchaseManager

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        required init(with purchaseManager: PurchaseManager) {
            self.purchaseManager = purchaseManager
        }
    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func didLoad() {
        purchaseManager.initialize { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//                case let .success(products):
//                default:
//                    break
//            }
        }

    }

    func restoreDidTap() {
        purchaseManager.restorePurchases { [weak self] _ in
            // Handle result
        }
    }

    func subscriptionDidTap(productId: String) {
        purchaseManager.purchaseProduct(productId: productId) { [weak self] _ in
        }

    }
}

extension Presenter: Module.InteractorOutput { }
