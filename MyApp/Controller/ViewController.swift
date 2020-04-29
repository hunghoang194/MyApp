//
//  ViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/20/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnShowLeftMenu: UIButton!
    let transiton = SlideInTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        for direction in [UISwipeGestureRecognizer.Direction.down, .up, .left, .right]{
            let swipeGest = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
            swipeGest.direction = direction
            self.view.addGestureRecognizer(swipeGest)
        }
    }
    @IBAction func nextScreen(_ sender: Any) {
        //        openFirtVC()
        
    }
    @IBAction func actionLogOut(_ sender: Any) {
        //        logOutDefault()
        logOutFB()
        nextHomeVCWhenLogOut()
    }
    @IBAction func actionShowLeftMenu(_ sender: Any) {
        showLeftMenu()
        
    }
    fileprivate func showLeftMenu() {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    func transitionToNew(_ menuType: MenuType) {
        switch menuType {
        case .profile:
            openFirtVC()
        case .camera:
            openSecondVC()
        default:
            break
        }
    }
    @objc func swipeAction(_ gesture: UISwipeGestureRecognizer){
        
        
    }
    
}
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
