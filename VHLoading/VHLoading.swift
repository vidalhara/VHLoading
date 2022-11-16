//
//  LoadingHelper.swift
//  VHLoadingHelper
//
//  Created by Vidal_HARA on 17.02.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit

/// This framework not only gives some choices to use but also you can set your own loading animator.
///
/// If you want to set your own loading, that view controller must confirm `VHLoading.Animator`.
///
/// You can set that ViewController by using `VHLoading.setAnimation(...)`.
///
/// - Attention: If `VHLoading.useNewWindow` is **false**, please **do not use** any function
/// of the VHLoading **before** the first view of the app did load.
/// This is because VHLoading needs the keyWindow to work.
open class VHLoading {

    /// Shared instance of VHLoading
    public private(set) static var shared = VHLoading()
    /// Type of ViewController which works with VHLoading
    public typealias Animator = VHLoadingProtocol

    /// If it is true Lock and Splash controllers are show in different UIWindow rather than main window.
    /// Default value is true.
    public var useNewWindow = true
    /// If this is true you **can not** change the lock type or unlock the screen until isForced is true again.
    /// Default value is false.
    public private(set) var isForced = false

    private lazy var splashItem = WindowLoadingItem(place: .splash)
    private lazy var lockItem = WindowLoadingItem(place: .lock)

    private var viewLoading: Animation = .default
    private var lockLoading: Animation = .default
    private var splashLoading: Animation = .defaultWith(
        backgroundColor: .init(red: 0.094, green: 0.094, blue: 0.094, alpha: 1)
    )

    /// You can lock your app screen with `Place.lock` or with `Place.splash`.
    ///
    /// - Parameters:
    ///   - place: Place to lock. **This has no effect if you choose `Place.view`
    ///   - isForced: If this is true you **can not** change the place type or
    ///   unlock the screen until isForced is true again.
    open func lockScreen(for place: VHLoading.Place = .lock, isForced: Bool = false) {
        guard self.isForced == isForced || isForced else { return }
        self.isForced = isForced

        switch place {
        case .lock:
          self.splashItem.hide()
          self.lockItem.show(with: self)
        case .splash:
          self.lockItem.hide()
          self.splashItem.show(with: self)
        case .view:
            return
        }
    }

    /// You can unlock your app screen for both lock and splash places.
    ///
    /// - Parameter isForced: This must be true if you lock screen with isForce true.
    open func unlockScreen(isForced: Bool = false) {
        guard VHLoading.shared.isForced == isForced || isForced else { return }
        self.isForced = false
        self.lockItem.hide()
        self.splashItem.hide()
    }

    /// You can set an animation for a `Place`.
    ///
    /// - Parameters:
    ///   - animation: Loading animation which you select.
    ///   - place: Place of the animation which will be shown
    open func setAnimation(_ animation: VHLoading.Animation, for place: VHLoading.Place) {
        switch place {
        case .view:
            viewLoading = animation
        case .splash:
            splashLoading = animation
        case .lock:
            lockLoading = animation
        }
    }

    /// You can get current instance of `Animator` for releated place if it is currently shown.
    ///
    /// - Attention: If place is `Place.view` return value will be nil. Every view contains its own animator.
    ///
    /// - Parameter place: Place of `VHLoading.Animator`.
    /// - Returns: Current animator for place.  If animator didn't set to place return value will be nil.
    open func animator(for place: VHLoading.Place) -> Animator? {
        switch place {
        case .view:
            return nil
        case .splash:
            return splashItem.controller?.embededController
        case .lock:
            return lockItem.controller?.embededController
        }
    }

    /// You can get new instance of Animator which is currently used by the framework.
    ///
    /// - Parameters:
    ///   - place: Place of the animator which will be shown
    /// - Returns: New instance of animator which will be shown in place.
    open func newAnimator(for place: VHLoading.Place) -> Animator {
        let viewController = newAnimatorInstance(for: place)
        viewController.loadViewIfNeeded()
        return viewController
    }

    private func newAnimatorInstance(for place: VHLoading.Place) -> Animator {
        switch place {
        case .view:
            return viewLoading.animator()
        case .splash:
            return splashLoading.animator()
        case .lock:
            return lockLoading.animator()
        }
    }
}
