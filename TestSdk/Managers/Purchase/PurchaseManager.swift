//
//  PurchaseManager.swift
//  TestSdk
//
//  Created by macuser on 11/1/21.
//

import Foundation
import StoreKit

enum PurchasesError {
    case setProductIds
    case disabled
    case restored
    case purchased

    var message: String {
        switch self {
        case .setProductIds: return "Product ids not set, call setProductIds method!"
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "You've successfully bought this purchase!"
        }
    }
}

class PurchaseManager: NSObject {

    // MARK: - Properties
    // MARK: - Private
    private let productIds = Set<String>(
        arrayLiteral: "unlockMusic.monthly.subscriptions",
        "unlockMusic.weekly.subscriptions",
        "unlockMusic.yearly.subscriptions"
    )

    fileprivate var productID = ""
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchProductComplition: (([SKProduct]) -> Void)?

    fileprivate var productToPurchase: SKProduct?
    fileprivate var purchaseProductComplition: ((PurchasesError, SKProduct?, SKPaymentTransaction?) -> Void)?
    fileprivate let defaults = UserDefaults.standard

    // MARK: - Public
    var isLogEnabled: Bool = true

    // MARK: - Methods
    // MARK: - Public

    // MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }

    func purchase(product: SKProduct, complition: @escaping ((PurchasesError, SKProduct?, SKPaymentTransaction?) -> Void)) {

        self.purchaseProductComplition = complition
        self.productToPurchase = product

        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)

            log("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            complition(PurchasesError.disabled, nil, nil)
        }

    }

    // RESTORE PURCHASE
    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts(complition: @escaping (([SKProduct]) -> Void)) {

        self.fetchProductComplition = complition
        // Put here your IAP Products ID's
        if self.productIds.isEmpty {
            log(PurchasesError.setProductIds.message)
            fatalError(PurchasesError.setProductIds.message)
        } else {
            productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
            productsRequest.delegate = self
            productsRequest.start()
        }
    }

    // MARK: - Private
    fileprivate func log <T> (_ object: T) {
        if isLogEnabled {
            NSLog("\(object)")
        }
    }
}

// MARK: - Product Request Delegate and Payment Transaction Methods

extension PurchaseManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {

    // REQUEST IAP PRODUCTS
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        if !response.products.isEmpty {
            if let complition = self.fetchProductComplition {
                var products = response.products

                products.sort(by: { (p0, p1) -> Bool in
                    p0.price.floatValue < p1.price.floatValue
                })

                complition(products)
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let complition = self.purchaseProductComplition {
            complition(PurchasesError.restored, nil, nil)
        }
    }

    // IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction: AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    log("Product purchase done")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let complition = self.purchaseProductComplition {
                        complition(PurchasesError.purchased, self.productToPurchase, trans)

                        let now = Date()
                        var expiredPaymentDate: Date?

                        if productID.contains(".weekly") {
                            expiredPaymentDate = now.addDays(n: 7)
                        }

                        if productID.contains(".monthly") {
                            expiredPaymentDate = now.addMonth(n: 1)
                        }

                        if productID.contains(".yearly") {
                            expiredPaymentDate = now.addYear(n: 1)
                        }

                        defaults.set(expiredPaymentDate, forKey: "expiredPaymentDate")
                    }

                case .failed:
                    log("Product purchase failed")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let complition = self.purchaseProductComplition {
                        complition(PurchasesError.disabled, self.productToPurchase, trans)

                        defaults.set(nil, forKey: "expiredPaymentDate")
                    }

                case .restored:
                    log("Product restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)

                default: break
                }}}
    }
}
