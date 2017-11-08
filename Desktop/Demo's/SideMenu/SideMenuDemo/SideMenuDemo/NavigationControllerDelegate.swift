//
//  NavigationControllerDelegate.swift
//  SideMenuDemo
//
//  Created by Nilesh's MAC on 9/30/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimator()
    }
}
