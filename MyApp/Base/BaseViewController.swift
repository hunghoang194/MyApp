//
//  BaseViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/20/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

class BaseViewController: UIViewController {
    var titleScreen = ""
    var dataArray : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    // MARK: Action
    @objc public func nextHomeVC() {
        let homeVC = Preferences.MainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @objc public func nextHomeVCWhenLogOut() {
        let loginVC = Preferences.LoginStoryboard.instantiateViewController(withIdentifier: "loginVC") as! MyALoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    @objc public func nextRegisterVC() {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as! MyARegisterViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc public func nextForgotPass() {
        let forgotPassVC = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassVC") as! MyAForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPassVC, animated: true)
    }
    func openFirtVC(){
        let nextScreen = self.storyboard?.instantiateViewController(withIdentifier: "BaseCollectionViewController") as! BaseCollectionViewController
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    func openSecondVC(){
        let nextScreen = self.storyboard?.instantiateViewController(withIdentifier: "BaseTableViewController") as! BaseTableViewController
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    @objc public func logOutDefault() -> Bool{
        do{
            try Auth.auth().signOut()
            return true
        }catch{
            return false
        }
    }
    @objc public func logOutFB() {
        let loginManager = LoginManager()
        loginManager.logOut()
        
        print("User logout")
        
    }
    @objc public func backButtonPress() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: ShowAlert
    @objc public func showError(string :String = "Plese enter email or password"){
        let alert = UIAlertController(title: "Warning", message: string, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: Check validate
    @objc public func isValidPassword(testPass:String?) -> Bool {
        let length: Int = testPass?.count ?? 0
        if length >= 6 {
            return true
        } else {
            return false
        }
    }
    @objc public func nextLoginVC() {
        let nextLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! MyALoginViewController
        self.navigationController?.pushViewController(nextLoginVC, animated: true)
    }
}
extension BaseViewController: UITextFieldDelegate {

 // Return button tapped
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
}

// Around tapped
@objc public func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}

@objc func dismissKeyboard() {
    view.endEditing(true)
    }
}
