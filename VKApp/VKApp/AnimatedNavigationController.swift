//
//  AnimatedNavigationController.swift
//  VKApp
//
//  Created by Ksenia Volkova on 21.03.2021.
//

import UIKit

class AnimatedNavigationController: UINavigationController {

    fileprivate let interactiveTransitionAnimator = InteractiveTransitionAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let edgePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(edgePanGestureStarted(_:)))
//        edgePanGestureRecognizer.edges = .left
        view.addGestureRecognizer(edgePanGestureRecognizer)
    }

    @objc private func edgePanGestureStarted(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransitionAnimator.hasStarted = true
            popViewController(animated: true)

        case .changed:
            let totalGestureDistance: CGFloat = 200
            let distance = recognizer.translation(in: recognizer.view).x
            let relativeDistance = distance / totalGestureDistance
            let progress = max(0, min(1, relativeDistance))

            interactiveTransitionAnimator.update(progress)
            interactiveTransitionAnimator.shouldFinish = progress > 0.35

        case .ended:
            interactiveTransitionAnimator.hasStarted = false
            if interactiveTransitionAnimator.shouldFinish {
                interactiveTransitionAnimator.finish()
            } else {
                interactiveTransitionAnimator.cancel()
            }

        case .cancelled:
            interactiveTransitionAnimator.hasStarted = false
            interactiveTransitionAnimator.cancel()
        default:
            break
        }
    }
}

extension AnimatedNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return PopAnimator()
        case .push:
            return PushAnimator()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransitionAnimator.hasStarted ? interactiveTransitionAnimator : nil
    }
}
