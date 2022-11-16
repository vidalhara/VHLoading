//
//  VHLockViewController.swift
//  VHLoadingHelper
//
//  Created by Vidal_HARA on 17.02.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit

class VHLockViewController: UIViewController {
    private let loadingIndicator: UIActivityIndicatorView = .init(style: .whiteLarge)

    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubviewWithCenter(loadingIndicator)
        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
    }

    required init?(coder: NSCoder) { return nil }
}

extension VHLockViewController: VHLoading.Animator {
    func startAnimating() {
        loadingIndicator.startAnimating()
    }

    func stopAnimating() {
        loadingIndicator.stopAnimating()
    }
}
