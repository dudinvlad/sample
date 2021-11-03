//
//  ContainerFactory.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 21.10.2021.
//

import Macaroni

class RestContainerFactory {
    // MARK: - Auth

    private lazy var welcomeAssembly = WelcomeModule.ModuleAssembly()
    private lazy var mainAuthAssembly = MainAuthModule.ModuleAssembly()
    private lazy var signupAssembly = SignupModule.ModuleAssembly()
    private lazy var loginAssembly = LoginModule.ModuleAssembly()
    private lazy var mainAssembly = MainFlowModule.ModuleAssembly()
    private lazy var alarmAssembly = AlarmModule.ModuleAssembly()
    private lazy var spotifyAssembly = AboutUsModule.ModuleAssembly()

    // MARK: - Subscriptions

    private lazy var subscriptionsAssembly = SubscriptionsModule.ModuleAssembly()

    // MARK: - Services

    private lazy var authService: AuthService = AuthServiceManager()
    private lazy var storageService: StorageService = DataBaseManager()
    private lazy var keychainStorage: StoreProtocol = KeychainStore()
    private lazy var spotifyManager: SpotifyManager = SpotifyManager()
    private lazy var purchaseManager: PurchaseManager = PurchaseManager()
    private lazy var notificationManager: NotificationManager = NotificationManager()

    func build() -> Container {
        let container = Container()

        // MARK: - Modules

        container.register { [welcomeAssembly]() -> WelcomeModule.ModuleAssemblying in welcomeAssembly }
        container.register { [mainAuthAssembly]() -> MainAuthModule.ModuleAssemblying in mainAuthAssembly }
        container.register { [signupAssembly]() -> SignupModule.ModuleAssemblying in signupAssembly }
        container.register { [loginAssembly]() -> LoginModule.ModuleAssemblying in loginAssembly }
        container.register { [mainAssembly]() -> MainFlowModule.ModuleAssemblying in mainAssembly }
        container.register { [alarmAssembly]() -> AlarmModule.ModuleAssemblying in alarmAssembly }
        container.register { [spotifyAssembly]() -> AboutUsModule.ModuleAssemblying in spotifyAssembly }

        // MARK: - Subscriptions
        container.register { [subscriptionsAssembly]() -> SubscriptionsModule.ModuleAssemblying in subscriptionsAssembly }

        // MARK: - Services

        container.register{ [authService]() -> AuthService in authService}
        container.register{ [storageService]() -> StorageService in storageService}
        container.register{ [keychainStorage]() -> StoreProtocol in keychainStorage}
        container.register{ [spotifyManager]() -> SpotifyManager in spotifyManager}
        container.register{ [purchaseManager]() -> PurchaseManager in purchaseManager}
        container.register{ [notificationManager]() -> NotificationManager in notificationManager}

        return container
    }
}

