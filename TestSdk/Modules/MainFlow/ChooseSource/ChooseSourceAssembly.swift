//
//  ChooseSourceAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = ChooseSourceModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var spotifyManager: SpotifyManager!
        @Injected var spotifyService: SpotifyService!
        @Injected var notificationManager: NotificationManager!
        @Injected var userDefaultsManager: UserDefaultsManager!
        @Injected var storageService: (StorageService & SoundtrackStoreService)!
        @Injected var spotifyMusicAssemblying: SpotifyMusicModule.ModuleAssemblying!
        @Injected var offlineMusicAssemblying: OfflineMusicModule.ModuleAssemblying!
        @Injected var subscriptionAssemblying: SubscriptionsModule.ModuleAssemblying
        @Injected var receiptService: ReceiptService!
        @Injected var purchaseManager: PurchaseManager!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(
                with: spotifyManager,
                notificationManager: notificationManager,
                userDefaultsManager: userDefaultsManager
            )
            let interactor: Interactor = .init(
                spotifyService: spotifyService,
                storageService: storageService,
                receiptService: receiptService,
                purchaseManager: purchaseManager
            )
            let router: Router         = .init(
                spotifyMusic: spotifyMusicAssemblying,
                userDefaultsManager: userDefaultsManager,
                offlineMusic: offlineMusicAssemblying,
                subscription: subscriptionAssemblying
            )

            viewController.output = presenter

            presenter.view       = viewController
            presenter.router     = router
            presenter.interactor = interactor

            interactor.output = presenter

            router.viewController = viewController

            return viewController
        }
    }
}
