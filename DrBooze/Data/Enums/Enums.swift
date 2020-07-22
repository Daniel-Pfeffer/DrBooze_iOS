//
// Created by Daniel Pfeffer on 19.06.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

enum StatusCodes: Int {
    case Ok = 200

    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case Conflict = 409
    case Teapot = 418

    case ServerError = 500
}

enum Case {
    case Sensitive
    case Insensitive
}