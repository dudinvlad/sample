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

    // MARK: - Services

    private lazy var authService: AuthService = AuthServiceManager()
    private lazy var storageService: StorageService = DataBaseManager()

    func build() -> Container {
        let container = Container()

        // MARK: - Modules

        container.register { [welcomeAssembly]() -> WelcomeModule.ModuleAssemblying in welcomeAssembly }
        container.register { [mainAuthAssembly]() -> MainAuthModule.ModuleAssemblying in mainAuthAssembly }
        container.register { [signupAssembly]() -> SignupModule.ModuleAssemblying in signupAssembly }
        container.register { [loginAssembly]() -> LoginModule.ModuleAssemblying in loginAssembly }

        // MARK: - Services

        container.register{ [authService]() -> AuthService in authService}
        container.register{ [storageService]() -> StorageService in storageService}

        return container
    }
}

