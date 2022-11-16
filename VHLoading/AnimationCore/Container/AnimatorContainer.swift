//
//  AnimatorContainer.swift
//  VHLoadingHelper
//
//  Created by Vidal_HARA on 17.02.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit

class AnimatorContainer: UIViewController {

    weak var embededController: VHLoading.Animator? {
        didSet {
            oldValue?.removeEmbededFromParent()
            if let newController = embededController {
                self.embed(controller: newController, toView: view)
            }
        }
    }

    var isAnimating = false {
        didSet {
            if oldValue != isAnimating {
                if isAnimating {
                    self.embededController?.startAnimating()
                } else {
                    self.embededController?.stopAnimating()
                }
            }
        }
    }

    init(animator: VHLoading.Animator) {
        embededController = animator
        super.init(nibName: nil, bundle: nil)
        self.embed(controller: animator, toView: view)
    }

    required init?(coder: NSCoder) { return nil }

    override var shouldAutorotate: Bool {
        return embededController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return embededController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return embededController?.preferredInterfaceOrientationForPresentation ??
        super.preferredInterfaceOrientationForPresentation
    }

    override var prefersStatusBarHidden: Bool {
        return embededController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return embededController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
}
