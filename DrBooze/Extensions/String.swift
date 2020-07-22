//
// Created by Daniel Pfeffer on 19.06.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

extension String {

    func hasPrefix(_ toSearch: String, case: Case) -> Bool {
        switch `case` {
        case .Insensitive:
            return self.lowercased().hasPrefix(toSearch.lowercased())
        case .Sensitive:
            return self.hasPrefix(toSearch)
        }
    }

    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }

    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        data(using: .utf8)!
    }

    func toDate() -> Date? {
        let formatter = DateFormatter(format: "dd.MM.yyyy")
        return formatter.date(from: self)
    }
}
