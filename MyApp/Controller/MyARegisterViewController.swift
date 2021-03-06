//
//  RegisterViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/21/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
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
        getInfoUsers()
        setupViewRegister()
        hideKeyboardWhenTappedAround()
        
    }
    @IBAction func actionBackScreen(_ sender: Any) {
        backButtonPress()
    }
    @IBAction func actionRegister(_ sender: Any) {
        checkValidUserName()
        
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
            showError(string: "Bạn vui lòng nhập thông tin email, sdt hoặc mật khẩu vào để đăng ký tài khoản")
            return
        }
        
        if confirmPassword != password {
            showError(string: "Mật khảu không giống nhau vui lòng kiểm tra lại")
            return
        }
        
        if !phoneNumber.isPhoneNumber == true, !UtilityFunction.checkIsEmail(inputStr: email) {
            showError(string: "Số điện thoại hoặc email không đúng định dạng")
            return
        }
        
        if (!self.isValidPassword(testPass: password) || !self.isValidPassword(testPass: confirmPassword) ){
            showError(string: "độ dài pass không đủ")
            return
        }
        if let check = UtilityFunction.entityExists(userName: userName) , check == true{
            //check thanh cong het thi vao day
            save(name: userName, password: password)
            nextLoginVC()
            showError(string: "đăng ký thành công")
        }else{
            showError(string: "Tài khoản đã tồn tại")
        }
        
    }

   
    func save(name: String, password: String) {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext =
        appDelegate.persistentContainer.viewContext
      let entity =
        NSEntityDescription.entity(forEntityName: "UsersModel",
                                   in: managedContext)!
      let users = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      users.setValue(name, forKeyPath: "userName")
      users.setValue(password, forKeyPath: "password")
      do {
        try managedContext.save()
        account.append(users)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    func getInfoUsers() {
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          let managedContext =
            appDelegate.persistentContainer.viewContext
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "UsersModel")
          do {
            account = try managedContext.fetch(fetchRequest)
            print(account)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
        passwordTextF.isSecureTextEntry = true
        confirmPasswordView.layer.cornerRadius = 25
        confirmPasswordView.layer.masksToBounds = true
        confirmPasswordView.layer.borderWidth = 1.0
        confirmPasswordView.layer.borderColor = UIColor.white.cgColor
        confirmPasswordTextF.attributedPlaceholder = NSAttributedString(string: "confirm password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmPasswordTextF.isSecureTextEntry = true
        btnRegister.layer.cornerRadius = 25
        btnRegister.layer.masksToBounds = true
        btnRegister.layer.borderWidth = 1.0
        btnRegister.layer.borderColor = UIColor.white.cgColor
    }
}
