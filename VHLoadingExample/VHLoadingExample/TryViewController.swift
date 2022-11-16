//
//  TryViewController.swift
//  VHLoadingExample
//
//  Created by Vidal_HARA on 8.01.2019.
//  Copyright © 2019 Vidal HARA. All rights reserved.
//

import UIKit
import VHLoading

class TryViewController: UIViewController {

    @IBAction func show() {
        view.showVHLoading()

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.view.hideVHLoading()
            }
        }
    }

    @IBAction func lock() {
        VHLoading.shared.lockScreen(for: .lock)

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                VHLoading.shared.unlockScreen()
            }
        }
    }

    @IBAction func splashLock() {
        VHLoading.shared.lockScreen(for: .splash)

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                VHLoading.shared.unlockScreen()
            }
        }
    }
}
