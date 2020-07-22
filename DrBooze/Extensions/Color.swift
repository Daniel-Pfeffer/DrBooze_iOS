//
// Created by Daniel Pfeffer on 19.06.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    // PRIMARY
    static var primary: Color {
        Color(red: 237.0/255.0, green: 111.0/255.0, blue: 113.0/255.0, opacity: 1.0)
    }
    static var secondary: Color {
        Color(red: 234.0/255.0, green: 86.0/255.0, blue: 87.0/255.0, opacity: 1.0)
    }
    static var tertiary: Color {
        Color(red: 216.0/255.0, green: 80.0/255.0, blue: 91.0/255.0, opacity: 1.0)
    }

    // INFORMATION
    static var success: Color {
        Color(red: 118.0/255.0, green: 115.0/255.0, blue: 216.0/255.0, opacity: 1.0)
    }
    static var warning: Color {
        Color(red: 255.0/255.0, green: 206.0/255.0, blue: 0, opacity: 1.0)
    }
    static var danger: Color {
        Color(red: 159.0/255.0, green: 0, blue: 61.0/255.0, opacity: 1.0)
    }

    // GREY
    static var dark: Color {
        Color(red: 34/255.0, green: 34.0/255.0, blue: 34.0/255.0, opacity: 1.0)
    }
    static var medium: Color {
        Color(red: 152.0/255.0, green: 152.0/255.0, blue: 152.0/255.0, opacity: 1.0)
    }
    static var light: Color {
        Color(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    }
}
