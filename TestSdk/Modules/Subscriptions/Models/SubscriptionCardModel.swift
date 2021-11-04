//
//  SubscriptionCardModel.swift
//  TestSdk
//
//  Created by macuser on 11/3/21.
//

import Foundation
import StoreKit

enum SubscriptionCardStyle {
    case selected
    case nonSelected
}

struct SubscriptionCardModel {
    let style: SubscriptionCardStyle
    let product: SKProduct
}
