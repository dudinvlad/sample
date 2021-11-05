//
//  Date+Extension.swift
//  TestSdk
//
//  Created by macuser on 11/5/21.
//

import Foundation

extension Date {
    func addDays(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: n, to: self) ?? Date()
    }

    func addMonth(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: n, to: self) ?? Date()
    }

    func addYear(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: n, to: self) ?? Date()
    }
}

