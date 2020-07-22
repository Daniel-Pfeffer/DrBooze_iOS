//
// Created by Daniel Pfeffer on 19.06.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import Moya

extension Moya.Response {
    func hasStatusCode(_ status: StatusCodes) -> Bool {
        self.statusCode == status.rawValue
    }
}