//
//  CircleTransitionAnimator.swift
//  SideMenuDemo
//
//  Created by Nilesh's MAC on 9/30/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1
        self.transitionContext = transitionContext
        
        //2
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! BaseViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! BaseViewController
        let button = fromViewController.view//fromViewController.centerBtn
    
        //3
        containerView.addSubview(toViewController.view)
        
        //4
        let frame = CGRect(x: (button?.center.x)! - 15, y: (button?.center.y)! - 15, width: 30, height: 30)
        let circleMaskPathInitial = UIBezierPath.init(ovalIn: frame)
        let extremePoint = CGPoint(x: (button?.center.x)! - 0, y: (button?.center.y)!)// - toViewController.view.frame.height) //CGRectGetHeight(toViewController.view.bounds))
        let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath.init(ovalIn: (button?.frame.insetBy(dx: -radius, dy: -radius))!) //CGRectInset((button?.frame)!, -radius, -radius))
        
        //5
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toViewController.view.layer.mask = maskLayer
        
        //6
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
    }
}
