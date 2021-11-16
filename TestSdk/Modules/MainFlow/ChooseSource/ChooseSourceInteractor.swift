//
//  ChooseSourceInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!

        private let spotifyService: SpotifyService
        private let storageService: (StorageService & SoundtrackStoreService)
        private let receiptService: ReceiptService
        private let purchaseManager: PurchaseManager


        required init(
            spotifyService: SpotifyService,
            storageService: (StorageService & SoundtrackStoreService),
            receiptService: ReceiptService,
            purchaseManager: PurchaseManager
        ) {
            self.spotifyService = spotifyService
            self.storageService = storageService
            self.receiptService = receiptService
            self.purchaseManager = purchaseManager
        }

    }
}

extension Interactor: Module.InteractorInput {
    func exchangeToken(with code: String) {
        spotifyService.exchangeAccessToken(with: code) { [weak self] accessToken, error in
            if let errorMessage = error {
                self?.output.controller?.showNetworking(error: errorMessage)
                return
            }
            self?.output.spotifySuccess(with: accessToken)
        }
    }

    func validateReceipt() {
        let receiptString = purchaseManager.getSubscriptionReceipt() ?? ""
        guard !receiptString.isEmpty else { self.output.receiptValidate(with: false); return }

        self.output.controller?.showActivity()
        receiptService.validate(receiptString) { response, error in
            self.output.controller?.hideActivity()
            if let error = error {
                self.output.receiptValidate(with: false)
            } else if let isValid = response {
                self.output.receiptValidate(with: isValid)
            }
        }
    }

    func fetchSavedTracks() {
        spotifyService.loadSavedTracks(offset: .zero) { [weak self] response, error in
            self?.output.success(with: response)
        }
    }

    func startPlayback(with device: String, uri: String) {}
}
