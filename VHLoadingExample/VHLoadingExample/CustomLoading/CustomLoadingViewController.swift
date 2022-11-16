//
//  CustomLoadingViewController.swift
//  VHLoadingExample
//
//  Created by Vidal_HARA on 8.04.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit
import VHLoading

class CustomLoadingViewController: UIViewController, VHLoading.Animator {

    @IBOutlet weak var topIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomIndicator: UIActivityIndicatorView!

    override var nibBundle: Bundle? { Bundle(for: CustomLoadingViewController.self) }
    override var nibName: String? { "CustomLoadingViewController" }

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomIndicator.transform = CGAffineTransform.init(scaleX: -1, y: 1)
    }

    func startAnimating() {
        topIndicator.startAnimating()
        bottomIndicator.startAnimating()
    }

    func stopAnimating() {
        topIndicator.stopAnimating()
        bottomIndicator.stopAnimating()
    }
}
