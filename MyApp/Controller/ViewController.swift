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
    var leftVC: LeftViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfileViewController()
        addGesture()

    }
    @IBAction func nextScreen(_ sender: Any) {
//        openFirtVC()
        showLeftViewController()
    }
    @IBAction func actionLogOut(_ sender: Any) {
//        logOutDefault()
        logOutFB()
        nextHomeVCWhenLogOut()
    }
    @IBAction func actionShowLeftMenu(_ sender: Any) {
        showLeftViewController()
    }
    
    fileprivate func initProfileViewController() {
        let leftVC = LeftViewController(nibName: "LeftViewController", bundle: nil)
        if let frame = UIApplication.shared.windows.last?.frame {
            leftVC.resetWidth(parentWidth: frame.width)
            leftVC.shadowColor = UIColor(red: 46.0/255, green: 24.0/255, blue: 82.0/255, alpha: 0.7)
            leftVC.hasShadow = true
            UIApplication.shared.windows.last?.addSubview(leftVC.view)
        }
        self.leftVC = leftVC
    }
    
    fileprivate func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapInSelf))
        self.view.addGestureRecognizer(gesture)
    }
    
    fileprivate func showLeftViewController() {
        leftVC?.expand()
    }
    
    @objc func tapInSelf() {
        leftVC?.close()
    }
}

