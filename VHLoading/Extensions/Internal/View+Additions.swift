//
//  View+Additions.swift
//  VHLoadingHelper
//
//  Created by Vidal_HARA on 17.02.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit

extension UIViewController {
    func removeEmbededFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    func embed(controller: UIViewController, toView: UIView) {
        self.addChild(controller)
        toView.addSubviewWithEdgeConstraints(controller.view)
        controller.didMove(toParent: self)
    }
}

extension UIView {
    func addSubviewWithEdgeConstraints(
        _ view: UIView, isSafeArea: Bool = false, insets: UIEdgeInsets = UIEdgeInsets.zero
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        if isSafeArea {
            let safeArea = self.safeAreaLayoutGuide
            view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: insets.left).isActive = true
            safeArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
            safeArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
            view.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: insets.top).isActive = true
        } else {
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        }
    }

    func addSubviewWithCenter(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: .zero).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: .zero).isActive = true
    }
}
