//
//  ForgotPasswordViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/21/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class MyAForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var forgotPassView: UIView!
    @IBOutlet weak var userNameTextF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewRegister()
        hideKeyboardWhenTappedAround()


    }
    @IBAction func actionBackScreen(_ sender: Any) {
        backButtonPress()
    }
    @IBAction func actionForgotPass(_ sender: Any) {
        showError(string: "Email khôi phục mật khẩu của bạn đã được gửi. Bạn vui lòng kiểm tra lại hòm thư của mình! ")
    }
    func setupViewRegister() {
        userNameTextF.attributedPlaceholder = NSAttributedString(string: "nhập tài khoản hoặc số điện thoại",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        forgotPassView.layer.cornerRadius = 25
        forgotPassView.layer.masksToBounds = true
        forgotPassView.layer.borderWidth = 1.0
        forgotPassView.layer.borderColor = UIColor.white.cgColor
        btnForgotPass.layer.cornerRadius = 25
        btnForgotPass.layer.masksToBounds = true
        btnForgotPass.layer.borderWidth = 1.0
        btnForgotPass.layer.borderColor = UIColor.white.cgColor
    }



}
