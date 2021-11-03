//
//  PurchaseManager.swift
//  TestSdk
//
//  Created by macuser on 11/1/21.
//

import Foundation
import StoreKit

typealias RequestProductsResult = Result<[SKProduct], Error>
typealias PurchaseProductResult = Result<Bool, Error>

typealias RequestProductsCompletion = (RequestProductsResult) -> Void
typealias PurchaseProductCompletion = (PurchaseProductResult) -> Void

enum PurchasesError: Error {
    case purchaseInProgress
    case productNotFound
    case unknown
}

class PurchaseManager: NSObject {

    private let productIdentifiers = Set<String>(
        arrayLiteral: "unlockMusic.monthly.subscriptions",
        "unlockMusic.weekly.subscriptions",
        "unlockMusic.yearly.subscriptions"
    )

    private var products: [String: SKProduct]?
    private var productRequest: SKProductsRequest?

    func initialize(completion: @escaping RequestProductsCompletion) {
        requestProducts(completion: completion)
    }

    private var productsRequestCallbacks = [RequestProductsCompletion]()

    private func requestProducts(completion: @escaping RequestProductsCompletion) {
        guard productsRequestCallbacks.isEmpty else {
            productsRequestCallbacks.append(completion)
            return
        }

        productsRequestCallbacks.append(completion)

        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()

        self.productRequest = productRequest
    }

    fileprivate var productPurchaseCallback: ((PurchaseProductResult) -> Void)?

    func purchaseProduct(productId: String, completion: @escaping (PurchaseProductResult) -> Void) {
        guard productPurchaseCallback == nil else {
            completion(.failure(PurchasesError.purchaseInProgress))
            return
        }

        guard let product = products?[productId] else {
            completion(.failure(PurchasesError.productNotFound))
            return
        }

        productPurchaseCallback = completion

        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    public func restorePurchases(completion: @escaping (PurchaseProductResult) -> Void) {
        guard productPurchaseCallback == nil else {
            completion(.failure(PurchasesError.purchaseInProgress))
            return
        }
        productPurchaseCallback = completion

        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


extension PurchaseManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard !response.products.isEmpty else {
            print("Found 0 products")

            productsRequestCallbacks.forEach { $0(.success(response.products)) }
            productsRequestCallbacks.removeAll()
            return
        }

        var products = [String: SKProduct]()
        for skProduct in response.products {
            print("Found product: \(skProduct.productIdentifier)")
            products[skProduct.productIdentifier] = skProduct
        }

        self.products = products

        productsRequestCallbacks.forEach { $0(.success(response.products)) }
        productsRequestCallbacks.removeAll()
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load products with error:\n \(error)")

        productsRequestCallbacks.forEach { $0(.failure(error)) }
        productsRequestCallbacks.removeAll()
    }
}

extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchased, .restored:
                    if finishTransaction(transaction) {
                        SKPaymentQueue.default().finishTransaction(transaction)
                        productPurchaseCallback?(.success(true))
                    } else {
                        productPurchaseCallback?(.failure(PurchasesError.unknown))
                    }

                case .failed:
                    productPurchaseCallback?(.failure(transaction.error ?? PurchasesError.unknown))
                    SKPaymentQueue.default().finishTransaction(transaction)
                default:
                    break
            }
        }

        productPurchaseCallback = nil
    }
}

extension PurchaseManager {
    func finishTransaction(_ transaction: SKPaymentTransaction) -> Bool {
        let productId = transaction.payment.productIdentifier
        print("Product \(productId) successfully purchased")
        return true
    }
}
