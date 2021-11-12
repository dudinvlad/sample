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

    // MARK: - Main

    private lazy var mainAssembly = MainFlowModule.ModuleAssembly()
    private lazy var alarmAssembly = AlarmModule.ModuleAssembly()
    private lazy var aboutUsAssembly = AboutUsModule.ModuleAssembly()
    private lazy var chooseMusicAssembly = ChooseMusicModule.ModuleAssembly()
    private lazy var chooseSourceAssembly = ChooseSourceModule.ModuleAssembly()
    private lazy var spotifyMusicAssembly = SpotifyMusicModule.ModuleAssembly()
    private lazy var offlineMusicAssembly = OfflineMusicModule.ModuleAssembly()

    // MARK: - Subscriptions

    private lazy var subscriptionsAssembly = SubscriptionsModule.ModuleAssembly()

    // MARK: - Services

    private lazy var authService: AuthService = AuthServiceManager()
    private lazy var storageService: (StorageService & SoundtrackStoreService) = StorageManager(keychainStorage)
    private lazy var keychainStorage: StoreProtocol = KeychainStore()
    private lazy var spotifyManager: SpotifyManager = SpotifyManager()
    private lazy var purchaseManager: PurchaseManager = PurchaseManager(userDefaultsManager)
    private lazy var apiManager: ApiManager = ApiManager()
    private lazy var spotifyService: SpotifyService = RestSpotifyService(apiManager)
    private lazy var notificationManager: NotificationManager = NotificationManager()
    private lazy var userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    private lazy var soundtreckService: SoundtrackService = RestSoundtrackService(apiManager)
    private lazy var soundStoreService: SoundtrackStoreService = LocalSoundtrackManager()
    private lazy var receiptService: ReceiptService = RestReceiptService(apiManager)

    func build() -> Container {
        let container = Container()

        // MARK: - Modules

        container.register { [welcomeAssembly]() -> WelcomeModule.ModuleAssemblying in welcomeAssembly }
        container.register { [mainAuthAssembly]() -> MainAuthModule.ModuleAssemblying in mainAuthAssembly }
        container.register { [signupAssembly]() -> SignupModule.ModuleAssemblying in signupAssembly }
        container.register { [loginAssembly]() -> LoginModule.ModuleAssemblying in loginAssembly }

        // MARK: - Main
        container.register { [mainAssembly]() -> MainFlowModule.ModuleAssemblying in mainAssembly }
        container.register { [alarmAssembly]() -> AlarmModule.ModuleAssemblying in alarmAssembly }
        container.register { [aboutUsAssembly]() -> AboutUsModule.ModuleAssemblying in aboutUsAssembly }
        container.register { [chooseMusicAssembly]() -> ChooseMusicModule.ModuleAssemblying in chooseMusicAssembly }
        container.register { [chooseSourceAssembly]() -> ChooseSourceModule.ModuleAssemblying in chooseSourceAssembly }
        container.register { [subscriptionsAssembly]() -> SubscriptionsModule.ModuleAssemblying in subscriptionsAssembly }
        container.register { [spotifyMusicAssembly]() -> SpotifyMusicModule.ModuleAssemblying in spotifyMusicAssembly }
        container.register { [offlineMusicAssembly]() -> OfflineMusicModule.ModuleAssemblying in offlineMusicAssembly }

        // MARK: - Services

        container.register{ [authService]() -> AuthService in authService}
        container.register{ [storageService]() -> (StorageService & SoundtrackStoreService) in storageService}
        container.register{ [keychainStorage]() -> StoreProtocol in keychainStorage}
        container.register{ [spotifyManager]() -> SpotifyManager in spotifyManager}
        container.register{ [purchaseManager]() -> PurchaseManager in purchaseManager}
        container.register{ [spotifyService]() -> SpotifyService in spotifyService}
        container.register{ [notificationManager]() -> NotificationManager in notificationManager}
        container.register{ [userDefaultsManager]() -> UserDefaultsManager in userDefaultsManager}
        container.register{ [soundtreckService]() -> SoundtrackService in soundtreckService}
        container.register { [soundStoreService]() -> SoundtrackStoreService in soundStoreService }
        container.register { [receiptService]() -> ReceiptService in receiptService }

        return container
    }
}

