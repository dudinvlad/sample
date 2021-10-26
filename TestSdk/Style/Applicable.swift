//
//  Applicable.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 22.10.2021.
//

import UIKit

// MARK: - Applicable

protocol Applicable {
    associatedtype Applicant

    func apply(_ object: Applicant)
}

precedencegroup StylePrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator <~: StylePrecedence

@discardableResult
func <~<T: Applicable>(object: T.Applicant, applicable: T) -> T.Applicant {
    applicable.apply(object)
    return object
}

func <~ (string: String, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
    NSAttributedString(string: string, attributes: attributes)
}

@discardableResult
func <~ (attributesTo: [NSAttributedString.Key: Any], attributesFrom: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
    var resultsAttributes = attributesTo
    attributesFrom.forEach { item in
        resultsAttributes[item.key] = item.value
    }
    return resultsAttributes
}

public func build<T>(_ object: T, builder: (T) -> Void) -> T {
    builder(object)
    return object
}

public func build<T: UIView>(builder: (T) -> Void) -> T {
    build(T(), builder: builder)
}

