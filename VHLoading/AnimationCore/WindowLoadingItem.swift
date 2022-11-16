//
//  WindowLoadingItem.swift
//  VHLoadingHelper
//
//  Created by Vidal_HARA on 17.02.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit

/// Your custom loading view controller must confirm this protocol for framework compatibility
public protocol VHLoadingProtocol: UIViewController {
    /// When you lock or show loading this function will be called.
    /// You can start your loading animation in this function.
    func startAnimating()

    /// When you unlock or hide loading this function will be called.
    /// You can stop your loading animation in this function.
    func stopAnimating()
}

class WindowLoadingItem {
    var controller: AnimatorContainer? { controllerAdaptor.controller }

    private var windowAdaptor: WindowAdaptor = NewWindowAdaptor()
    private var controllerAdaptor: ControllerAdaptor = RootControllerAdaptor()
    private let place: VHLoading.Place

    init(place: VHLoading.Place) {
        self.place = place
    }

    func show(with service: VHLoading) {
        windowAdaptor = service.useNewWindow ? NewWindowAdaptor() : KeyWindowAdaptor()
        controllerAdaptor = service.useNewWindow ? RootControllerAdaptor() : SubviewControllerAdaptor()

        if windowAdaptor.needsConfigure {
            controllerAdaptor.configure(with: service, at: place)
            windowAdaptor.configure(with: controllerAdaptor.controller)
        }
        controllerAdaptor.show(with: windowAdaptor)
    }

    func hide() {
        controllerAdaptor.hide()
        windowAdaptor.hide()
    }
}

// MARK: - ControllerAdaptor

private protocol ControllerAdaptor: AnyObject {
    var controller: AnimatorContainer? { get set }

    func configure(with service: VHLoading, at place: VHLoading.Place)
    func show(with adaptor: WindowAdaptor)
    func hide()
}

extension ControllerAdaptor {
    func configure(with service: VHLoading, at place: VHLoading.Place) {
        controller = AnimatorContainer(animator: service.newAnimator(for: place))
    }

    func show(with adaptor: WindowAdaptor) {
        guard let controller = controller else { return }
        controller.isAnimating = true
        adaptor.show(with: controller)
    }
}

private final class SubviewControllerAdaptor: ControllerAdaptor {
    var controller: AnimatorContainer?
    func hide() {
        controller?.isAnimating = false
        controller?.view.removeFromSuperview()
        controller = nil
    }
}

private final class RootControllerAdaptor: ControllerAdaptor {
    var controller: AnimatorContainer?

    func hide() {
        controller?.isAnimating = false
        controller = nil
    }
}

// MARK: - WindowAdaptor

private protocol WindowAdaptor {
    var needsConfigure: Bool { get }
    var isKeyWindow: Bool { get }
    func configure(with controller: UIViewController?)
    func show(with controller: UIViewController)
    func hide()
}

private final class NewWindowAdaptor: WindowAdaptor {
    var needsConfigure: Bool { window == nil }
    let isKeyWindow: Bool = false

    private var window: UIWindow?

    func configure(with controller: UIViewController?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.isHidden = true
        window?.rootViewController = controller
        controller?.loadViewIfNeeded()
        window?.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
    }

    func show(with controller: UIViewController) {
        window?.isHidden = false
    }

    func hide() {
        window?.isHidden = true
        window = nil
    }
}

private final class KeyWindowAdaptor: WindowAdaptor {
    var needsConfigure: Bool { window == nil }
    let isKeyWindow: Bool = true

    private var window: UIWindow?

    func configure(with controller: UIViewController?) {
        window = UIApplication.shared.keyWindow
    }

    func show(with controller: UIViewController) {
        window?.addSubviewWithEdgeConstraints(controller.view)
    }

    func hide() {
        window = nil
    }
}
