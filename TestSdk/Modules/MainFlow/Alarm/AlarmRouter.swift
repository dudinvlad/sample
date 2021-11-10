//
//  AlarmRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = AlarmModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        
        private let chooseMusicAssemblying: ChooseMusicModule.ModuleAssemblying
        private let subscriptionsAssemblying: SubscriptionsModule.ModuleAssemblying
        private let mainAuthAssemblying: MainAuthModule.ModuleAssemblying

        required init(
            chooseMusic: ChooseMusicModule.ModuleAssemblying,
            subscription: SubscriptionsModule.ModuleAssemblying,
            mainAuth: MainAuthModule.ModuleAssemblying

        ) {
            self.chooseMusicAssemblying = chooseMusic
            self.subscriptionsAssemblying = subscription
            self.mainAuthAssemblying = mainAuth
        }
    }
}

extension Router: Module.RouterInput {
    func presentChooseMusic(didSelectTrackHandler:(() -> Void)? ) {
        let naviggationController = UINavigationController(rootViewController: chooseMusicAssemblying.assemble(with: didSelectTrackHandler))

        viewController.present(naviggationController, animated: true)
    }

    func presentSubscriptionFlow() {
        viewController.present(subscriptionsAssemblying.assemble(), animated: true, completion: nil)
    }

    func presentAuthFlow() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = UINavigationController(rootViewController: mainAuthAssemblying.assemble())
    }
}
