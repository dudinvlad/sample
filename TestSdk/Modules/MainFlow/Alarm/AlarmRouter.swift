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

        required init(
            chooseMusic: ChooseMusicModule.ModuleAssemblying
        ) {
            self.chooseMusicAssemblying = chooseMusic
        }
    }
}

extension Router: Module.RouterInput {
    func presentChooseMusic() {
        let naviggationController = UINavigationController(rootViewController: chooseMusicAssemblying.assemble())
        viewController.present(naviggationController, animated: true)
    }
}
