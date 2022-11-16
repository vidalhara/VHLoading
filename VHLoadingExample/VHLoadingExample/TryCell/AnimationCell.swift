//
//  AnimationCell.swift
//  VHLoadingExample
//
//  Created by Vidal HARA on 27.09.2022.
//  Copyright © 2022 Vidal HARA. All rights reserved.
//

import UIKit

class AnimationCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!

    func configure(with text: String) {
        label.text = text
    }
}
