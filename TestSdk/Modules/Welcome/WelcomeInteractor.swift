//
//  WelcomeInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = WelcomeModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!

        required init() { }

    }
}

extension Interactor: Module.InteractorInput { }
