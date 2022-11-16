//
//  CoreGraphics+Additions.swift
//  VHLoading
//
//  Created by Vidal HARA on 27.09.2022.
//  Copyright © 2022 Vidal HARA. All rights reserved.
//

import CoreGraphics

extension CGSize {

    init(square value: CGFloat) {
        self.init(width: value, height: value)
    }
}
