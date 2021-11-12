//
//  ChooseMusicAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = ChooseMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var chooseSourceModule: ChooseSourceModule.ModuleAssemblying!
        @Injected var userDefaultsManager: UserDefaultsManager!
        @Injected var notificationManager: NotificationManager!
        @Injected var storageService: (StorageService & SoundtrackStoreService)!
        @Injected var soundStoreService: SoundtrackStoreService!

        func assemble(with complition: (() -> Void)?) -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(
                userDefaultsManager: userDefaultsManager,
                notificationManager: notificationManager,
                storageService: storageService,
                trackDidSelectHandler: complition,
                soundStoreService: soundStoreService
            )
            let interactor: Interactor = .init()
            let router: Router         = .init(
                chooseSourceModule: chooseSourceModule
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
