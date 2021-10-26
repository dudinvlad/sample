//
//  MainAuthInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = MainAuthModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!

        required init() { }

    }
}

extension Interactor: Module.InteractorInput { }
