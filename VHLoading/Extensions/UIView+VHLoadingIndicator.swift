//
//  UIView+VHLoadingIndicator.swift
//  VHLoading
//
//  Created by Vidal HARA on 11.09.2020.
//  Copyright © 2020 Vidal HARA. All rights reserved.
//

import UIKit

public extension UIView {

    private struct AssociationKeys {
        static var vhLoadingViewController = "ws_vhloading_internal_loadingIndicatorView"
    }

    @objc private var vhLoadingViewController: AnimatorContainer? {
        get {
            return objc_getAssociatedObject(self, &AssociationKeys.vhLoadingViewController) as? AnimatorContainer
        }
        set {
            objc_setAssociatedObject(
                self, &AssociationKeys.vhLoadingViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    /// You can put an animator to top of your view.
    /// - Parameters:
    ///   - controller: Animator to add as subview
    ///   - addingView: Add animator view as subview and add constraints
    func showVHLoading(controller: VHLoading.Animator = VHLoading.shared.newAnimator(for: .view)) {
        showVHLoading(controller: controller) { [unowned self] animator in
            self.addSubviewWithEdgeConstraints(animator)
        }
    }

    /// You can put an animator to a view
    /// - Parameters:
    ///   - controller: Animator to add as subview
    ///   - addingView: Add animator view as subview and add constraints
    func showVHLoading(
        controller: VHLoading.Animator = VHLoading.shared.newAnimator(for: .view),
        addingView: (UIView) -> Void
    ) {
        hideVHLoading()
        let loadingViewController: AnimatorContainer = .init(animator: controller)

        vhLoadingViewController = loadingViewController
        loadingViewController.isAnimating = true
        addingView(loadingViewController.view)
        loadingViewController.view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    }

    /// You can hide the loading you show.
    @objc func hideVHLoading() {
        vhLoadingViewController?.view.removeFromSuperview()
        vhLoadingViewController?.isAnimating = false
        vhLoadingViewController = nil
    }
}
