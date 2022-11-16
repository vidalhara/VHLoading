//
//  VHDotsViewController.swift
//  VHLoading
//
//  Created by Vidal Hara on 7.01.2019.
//  Copyright © 2019 Vidal HARA. All rights reserved.
//

import UIKit

/// This is a preset animation `VHLoadingAnimations.dots`
open class VHDotsViewController: UIViewController {
    /// Number of dots
    open var dotCount: Int = 3 {
        didSet {
            loadingIndicator.dotCount = dotCount
        }
    }

    /// Radius of the dots
    open var dotRadius: CGFloat = 6.0 {
        didSet {
            loadingIndicator.dotRadius = dotRadius
        }
    }

    /// Space between dots
    open var dotsSpacing: CGFloat = 10 {
        didSet {
            loadingIndicator.dotsSpacing = dotsSpacing
        }
    }

    /// Color of the dots
    open var color: UIColor = #colorLiteral(red: 0.26, green: 0.47, blue: 0.96, alpha: 1) {
        didSet {
            loadingIndicator.color = color
        }
    }

    private let loadingIndicator: DotView = .init(frame: .zero)

    /// Creates a view controller
    public init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubviewWithEdgeConstraints(loadingIndicator, isSafeArea: true)
    }

    /// Not supported
    public required init?(coder: NSCoder) { return nil }
}

extension VHDotsViewController: VHLoading.Animator {
    open func startAnimating() {
        loadingIndicator.startAnimating()
    }

    open func stopAnimating() {
        loadingIndicator.stopAnimating()
    }
}
