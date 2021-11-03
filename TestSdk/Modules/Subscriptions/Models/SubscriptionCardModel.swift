//
//  SubscriptionCardModel.swift
//  TestSdk
//
//  Created by macuser on 11/1/21.
//

import Foundation

enum SubscriptionCardStyle {
    case selected
    case nonSelected
}

struct SubscriptionCardModel {
    let style: SubscriptionCardStyle
    let period: String
    let price: Float
    let per: String
    let productId: String

}

