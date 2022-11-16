//
//  ThreeDotView.swift
//  VHLoading
//
//  Created by Vidal Hara on 7.01.2019.
//  Copyright © 2019 Vidal HARA. All rights reserved.
//

import UIKit

class DotView: UIView {
    var dotCount: Int = 3 {
        didSet {
            layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            dotLayers.removeAll()
            setupDotLayers()
        }
    }

    var dotRadius: CGFloat = 6.0 {
        didSet {
            dotLayers.forEach { [weak self] in self?.configureRadius(of: $0) }
            setNeedsLayout()
        }
    }

    var dotsSpacing: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }

    public var color: UIColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1) {
        didSet {
            dotLayers.forEach { $0.fillColor = color.cgColor }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDotLayers()
    }

    required public init?(coder aDecoder: NSCoder) { return nil }

    // MARK: - View Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        let dotWidth = dotRadius * 2
        let unitGap = dotWidth + dotsSpacing
        let totalWidth = unitGap * CGFloat(dotCount) - dotsSpacing
        let startPoint = bounds.midX - (totalWidth / 2)

        for (index, layer) in dotLayers.enumerated() {
            let pointX = startPoint + CGFloat(index) * unitGap
            layer.position = CGPoint(x: pointX + dotRadius, y: bounds.midY)
        }
        startAnimating()
    }

    func startAnimating() {
        dotLayers.startAnimations()
    }

    func stopAnimating() {
        dotLayers.removeAnimations()
    }

    private var dotLayers = [CAShapeLayer]()

    private func configureRadius(of layer: CAShapeLayer) {
        layer.bounds = CGRect(origin: .zero, size: CGSize(square: dotRadius * 2.0))
        layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: dotRadius).cgPath
    }

    private func setupDotLayers() {
        for _ in 0..<dotCount {
            let dotLayer = self.dotLayer()
            dotLayers.append(dotLayer)
            layer.addSublayer(dotLayer)
        }
    }

    private func dotLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        self.configureRadius(of: layer)
        layer.fillColor = color.cgColor
        return layer
    }

    fileprivate struct Constants {
        static let dotsScale: Double = 1.3
        static let scaleMaxDuration: CFTimeInterval = 0.3
        static let scaleMinDuration: CFTimeInterval = 0.2
        static var animationDuration: CFTimeInterval { scaleMaxDuration + scaleMinDuration }
    }
}

// MARK: - Array(CAShapeLayer)

private extension Array where Element: CAShapeLayer {

    func startAnimations() {
        var offset: TimeInterval = .zero
        let unitPrefixDelay = DotView.Constants.animationDuration / 2
        let totalDuration = unitPrefixDelay * Double(self.count)

        self.forEach {
            $0.removeAllAnimations()
            let animation = scaleAnimation(offset, suffixDelay: totalDuration - offset - unitPrefixDelay)
            $0.add(animation, forKey: "dotView.scaleAnimation")
            offset += unitPrefixDelay
        }
    }

    func removeAnimations() {
        self.forEach { $0.removeAllAnimations() }
    }
}

// MARK: - Scale Animation

private extension Array where Element: CAShapeLayer {

    func scaleAnimation(_ after: CFTimeInterval, suffixDelay: CFTimeInterval) -> CAAnimationGroup {
        let scaleMax = self.scaleMax(after)
        let scaleMin = self.scaleMin(after + scaleMax.duration)
        let stayAsMin = self.stayAsMin(scaleMin.beginTime + scaleMin.duration, duration: suffixDelay)

        let group = CAAnimationGroup()
        group.animations = [scaleMax, scaleMin, stayAsMin]
        group.repeatCount = Float.infinity
        group.duration = stayAsMin.beginTime + stayAsMin.duration
        return group
    }

    func scaleMax(_ after: CFTimeInterval) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.beginTime = after
        scale.fromValue = 1
        scale.toValue = DotView.Constants.dotsScale
        scale.duration = DotView.Constants.scaleMaxDuration
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        return scale
    }

    func scaleMin(_ after: CFTimeInterval) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.beginTime = after
        scale.fromValue = DotView.Constants.dotsScale
        scale.toValue = 1
        scale.duration = DotView.Constants.scaleMinDuration
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        return scale
    }

    func stayAsMin(_ after: CFTimeInterval, duration: CFTimeInterval) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.beginTime = after
        scale.fromValue = 1
        scale.toValue = 1
        scale.duration = duration
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        return scale
    }
}
