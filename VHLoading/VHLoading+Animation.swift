//
//  VHLoading+Animation.swift
//  VHLoading
//
//  Created by Vidal HARA on 11.09.2020.
//  Copyright © 2020 Vidal HARA. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
public extension VHLoading {

    /// Preset Loading Animation Types
    ///
    /// - `default`: Only a basic indicator
    /// - dots: Multiple dot loading
    enum Animation {
        /// This animation uses a normal indicator
        case `default`
        /// This animation uses a normal indicator with background color
        case defaultWith(backgroundColor: UIColor)
        /// This animation uses `VHDotsViewController`
        case dots
        /// This animation uses a custom controller which supplied by you
        case custom(() -> Animator)

        /// Generates a new animator for related type
        /// - Returns: New animator
        public func animator() -> Animator {
            switch self {
            case .default:
                return VHLockViewController()
            case .defaultWith(let backgroundColor):
                let controller = VHLockViewController()
                controller.view.backgroundColor = backgroundColor
                return controller
            case .dots:
                return VHDotsViewController()
            case .custom(let source):
                return source()
            }
        }
    }
}
// swiftlint:enable identifier_name
