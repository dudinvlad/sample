//
//  SubscriptionsPresenter.swift
//  TestSdk
//
//  Created macuser on 10/29/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit

private typealias Module = SubscriptionsModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        private let purchaseManager: PurchaseManager

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        required init(
            with purchaseManager: PurchaseManager
        ) {
            self.purchaseManager = purchaseManager
        }
    }
}

private extension Presenter {
    func handleSuccessSubscription(_ error: PurchasesError) {
        if error != .disabled {
            guard self.view != nil else { return }

            self.view.successPurchase()
        }
    }
}

extension Presenter: Module.ViewOutput {
    func didLoad() {
        purchaseManager.fetchAvailableProducts { products in
            var dataSourse = [SubscriptionCardModel]()

            for (index, product) in products.enumerated() {
                if index == 1 {
                    dataSourse.append(SubscriptionCardModel(style: .selected, product: product))
                } else {
                    dataSourse.append(SubscriptionCardModel(style: .nonSelected, product: product))
                }
            }
            self.view.set(dataSource: dataSourse)
        }
    }

    func restoreDidTap() {
        purchaseManager.restorePurchase() { error, product, transaction in
            self.handleSuccessSubscription(error)
        }
    }

    func subscriptionDidTap(product: SKProduct) {
        purchaseManager.purchase(product: product) { error, product, transaltion in
            self.handleSuccessSubscription(error)
        }
    }
}

extension Presenter: Module.InteractorOutput { }
