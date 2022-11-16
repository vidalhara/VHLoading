//
//  VHLoading+Place.swift
//  VHLoading
//
//  Created by Vidal HARA on 11.09.2020.
//  Copyright © 2020 Vidal HARA. All rights reserved.
//

import Foundation

public extension VHLoading {

    /// Places can be shown for loading controllers.
    enum Place {
        /// Place to use animations in UIView
        case view
        /// Place to use animations in Splash Screen
        case splash
        /// Place to use animations in Lock Screen
        case lock
    }
}
