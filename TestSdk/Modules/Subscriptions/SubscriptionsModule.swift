//
//  SubscriptionsModule.swift
//  TestSdk
//
//  Created macuser on 10/29/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SubscriptionsModule {
    typealias ModuleAssemblying = SubscriptionsAssemblyProtocol
    typealias ViewInput         = SubscriptionsViewInputProtocol
    typealias ViewOutput        = SubscriptionsViewOutputProtocol
    typealias InteractorInput   = SubscriptionsInteractorInputProtocol
    typealias InteractorOutput  = SubscriptionsInteractorOutputProtocol
    typealias RouterInput       = SubscriptionsRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol SubscriptionsAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol SubscriptionsViewInputProtocol: AnyObject { }

protocol SubscriptionsViewOutputProtocol: BaseViewOutput {
  	func restoreDidTap()
    func subscriptionDidTap(productId: String)
}

// MARK: - Interactor

protocol SubscriptionsInteractorInputProtocol { }

protocol SubscriptionsInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol SubscriptionsRouterInputProtocol { }
