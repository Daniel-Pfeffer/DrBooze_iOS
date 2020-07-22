//
// Created by Daniel Pfeffer on 19.06.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

extension Date {
    var startOfMonth: Date? {
        var date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))
        return date?.addHours(2)
    }

    var endOfMonth: Date? {
        var date = startOfMonth
        date = date?.addMonth(1)
        return date?.addDays(-1)
    }

    var humanReadable: String {
        let formatter = DateFormatter(format: "dd.MM.yy")
        return formatter.string(from: self)
    }

    mutating func addHours(_ cnt: Int) -> Date? {
        let cal = Calendar.current
        let date = cal.date(byAdding: .hour, value: cnt, to: self)
        return date
    }

    mutating func addDays(_ cnt: Int) -> Date? {
        let cal = Calendar.current
        let date = cal.date(byAdding: .day, value: cnt, to: self)
        return date
    }

    mutating func addMonth(_ cnt: Int) -> Date? {
        let cal = Calendar.current
        let date = cal.date(byAdding: .month, value: cnt, to: self)
        return date
    }
}

extension DateFormatter {
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}