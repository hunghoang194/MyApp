//
//  RegisterViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/21/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class MyARegisterViewController: BaseViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameTextF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextF: UITextField!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordTextF: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    //core data
    var account: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewRegister()
        hideKeyboardWhenTappedAround()
        
    }
    @IBAction func actionBackScreen(_ sender: Any) {
        backButtonPress()
    }
    @IBAction func actionRegister(_ sender: Any) {
        checkValidUserName()
        
    }
    func createUser(){
        let email: String = (self.emailTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let userName: String = (self.userNameTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.passwordTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        Auth.auth().createUser(withEmail: userName, password: password) { authResult, error in
            if(error != nil) {
                self.showError(string: "error")
                print(error)
                return
            }
            self.showError(string: "user create")
        }
    }
    func checkValidUserName() {
        let email: String = (self.emailTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let userName: String = (self.userNameTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.passwordTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let confirmPassword: String = (self.confirmPasswordTextF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        var phoneNumber = userName
        if (userName.count) > 0 {
            let firstSubString = String(userName.prefix(3))
            if  firstSubString == "+84"{
                phoneNumber = userName.replacingOccurrences(of: "+84", with: "0", options: .literal, range: nil)
            }
            if String(userName.prefix(2)) == "84" {
                 phoneNumber = userName.replacingOccurrences(of: "84", with: "0", options: .literal, range: nil)
            }
        }
        if (email.isEmpty || userName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            showError(string: "Bạn vui lòng nhập thông tin email, sdt hoặc password vào để đăng ký tài khoản")
            return
        }
        
        if confirmPassword != password {
            showError(string: "Password không giống nhau vui lòng kiểm tra lại")
            return
        }
        
        if !phoneNumber.isPhoneNumber == true, !UtilityFunction.checkIsEmail(inputStr: email) {
            showError(string: "Số điện thoại hoặc email không đúng định dạng")
            return
        }
        
        if (!self.isValidPassword(testPass: password) || !self.isValidPassword(testPass: confirmPassword) ){
            showError(string: "do dai pass k du")
            return
        }
        //check thanh cong het thi vao day


        
//        Auth.auth().createUser(withEmail: userName, password: password) { authResult, error in
//            if(error != nil) {
//                self.showError(string: "error")
//                print(error)
//                return
//            }
//            self.showError(string: "user create")
//        }

        nextLoginVC()
        showError(string: "đăng ký thành công")
    }
    func save(name: String, password: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
      person.setValue(password, forKeyPath: "password")
      
      // 4
      do {
        try managedContext.save()
        account.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    func setupViewRegister() {
        emailView.layer.cornerRadius = 25
        emailView.layer.masksToBounds = true
        emailView.layer.borderWidth = 1.0
        emailView.layer.borderColor = UIColor.white.cgColor
        emailTextF.attributedPlaceholder = NSAttributedString(string: "email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        userNameView.layer.cornerRadius = 25
        userNameView.layer.masksToBounds = true
        userNameView.layer.borderWidth = 1.0
        userNameView.layer.borderColor = UIColor.white.cgColor
        userNameTextF.attributedPlaceholder = NSAttributedString(string: "user name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordView.layer.cornerRadius = 25
        passwordView.layer.masksToBounds = true
        passwordView.layer.borderWidth = 1.0
        passwordView.layer.borderColor = UIColor.white.cgColor
        passwordTextF.attributedPlaceholder = NSAttributedString(string: "password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmPasswordView.layer.cornerRadius = 25
        confirmPasswordView.layer.masksToBounds = true
        confirmPasswordView.layer.borderWidth = 1.0
        confirmPasswordView.layer.borderColor = UIColor.white.cgColor
        confirmPasswordTextF.attributedPlaceholder = NSAttributedString(string: "confirm password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        btnRegister.layer.cornerRadius = 25
        btnRegister.layer.masksToBounds = true
        btnRegister.layer.borderWidth = 1.0
        btnRegister.layer.borderColor = UIColor.white.cgColor
    }
}
