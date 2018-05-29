//
//  PIP.swift
//  PIP
//
//  Created by Felipe Kimio Nishikaku on 28/05/18.
//

import UIKit

public class PIPConfiguration {
    public var basePipView: UIView
    public var viewToPip: UIView
    public var pipWidth: CGFloat = 0.0
    public var pipHeight: CGFloat = 0.0
    public var animateDuration: TimeInterval = 0.3
    public var pipSizePercentage: CGFloat = 4.0
    
    public init(viewToPip: UIView) {
        self.viewToPip = viewToPip
        self.basePipView = viewToPip.superview!
    }
    
    public init(viewToPip: UIView, basePipView: UIView) {
        self.viewToPip = viewToPip
        self.basePipView = basePipView
    }
}

public class PIP {
    
    public var configuration: PIPConfiguration!
    private var hangAroundPanGesture: UIPanGestureRecognizer!
    
    public init() { }
    
    private func pipSize() {
        configuration.pipWidth = (configuration.basePipView.frame.width / configuration.pipSizePercentage) * (16 / 9)
        configuration.pipHeight = (configuration.basePipView.frame.height / configuration.pipSizePercentage) * (9 / 16)
    }
    
    public func updatePipRect(_ rect: CGRect) {
        UIView.animate(withDuration: configuration.animateDuration, animations: {
            self.configuration.viewToPip.frame = rect
        })
    }
    
    public func addPictureInPicture(configuration: PIPConfiguration) {
        self.configuration = configuration
        pipSize()
        hangAroundPanGesture = UIPanGestureRecognizer(target: self, action: #selector(hangAround(_:)))
        hangAroundPanGesture.isEnabled = true
        configuration.viewToPip.addGestureRecognizer(hangAroundPanGesture)
        configuration.viewToPip.isUserInteractionEnabled = true
    }
    
    @objc func hangAround(_ gesture: UIPanGestureRecognizer) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let viewFrame = configuration.basePipView.frame
        
        let locationInWindow = gesture.location(in: window)
        let targetRect = CGRect(x: locationInWindow.x - configuration.pipWidth / 2,
                                y: locationInWindow.y - configuration.pipHeight / 2,
                                width: configuration.pipWidth, height: configuration.pipHeight)
        
        switch gesture.state {
        case .began,
             .changed:
            if targetRect.origin.x > 0,
                targetRect.origin.x + configuration.pipWidth < viewFrame.width,
                targetRect.origin.y > 0,
                targetRect.origin.y + configuration.pipHeight < viewFrame.height {
                
                updatePipRect(targetRect)
            }
            break
        case .ended:
            var xPosition: CGFloat = 0.0
            var yPosition: CGFloat = 0.0
            let percentageX = (targetRect.origin.x * 100 / viewFrame.width ) / 100
            let percentageY = (targetRect.origin.y * 100 / viewFrame.height ) / 100
            if percentageX > 0.4 {
                xPosition = viewFrame.width - configuration.pipWidth
            }
            if percentageY > 0.4 {
                yPosition = viewFrame.height - configuration.pipHeight
            }
            if xPosition == viewFrame.width - configuration.pipWidth,
                yPosition == 0 {
                let viewFrame = configuration.basePipView.frame
                updatePipRect(CGRect(x: 0,
                                     y: 0,
                                     width: viewFrame.width,
                                     height: viewFrame.height))
            } else {
                updatePipRect(CGRect(x: xPosition,
                                     y: yPosition,
                                     width: configuration.pipWidth,
                                     height: configuration.pipHeight))
            }
            break
        default: break
        }
    }
}
