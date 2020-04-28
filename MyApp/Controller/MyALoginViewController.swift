//
//  LoginViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/21/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FacebookCore
import FacebookLogin
import FirebaseAuth
import GoogleSignIn

class MyALoginViewController: BaseViewController, GIDSignInDelegate {
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var btnGoogle: GIDSignInButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForGotPassword: UIButton!
    var isLogin: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        setupViewLogin()
        hideKeyboardWhenTappedAround()
        Defaults.save("a@gmail.com", password: "123456")
    }
    // MARK: Action
    @IBAction func actionLoginDefault(_ sender: Any) {
        checkValidUserName()
    }
    @IBAction func actionLoginFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile,.email],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
        
    }
    @IBAction func actionLoginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func actionForGotPassword(_ sender: Any) {
        nextForgotPass()
    }
    @IBAction func actionRegister(_ sender: Any) {
        nextRegisterVC()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Login Successful")
                //This is where you should add the functionality of successful login
                //i.e. dismissing this view or push the home view controller etc
            }
        }
        
    }
    func checkLogin(){
        if let accessToken = AccessToken.current {
        }
    }
    func getFBUserData() {
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name,birthday,gender, picture.width(480).height(480)"])
        graphRequest.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print(result)
            } else {
                Preferences.sharedInstance.userModel = MyAUserProfile()
                let field = result! as? [String:Any]
                Preferences.sharedInstance.userModel!.name = field!["name"] as? String
                Preferences.sharedInstance.userModel!.email = field!["email"] as? String
                Preferences.sharedInstance.userModel!.birthday = field!["birthday"] as? String
                Preferences.sharedInstance.userModel!.gender = field!["gender"] as? String
                if let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    print(imageURL)
                    let url = URL(string: imageURL)
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                    Preferences.sharedInstance.userModel!.image = image
                }
            }
        }
        )
    }
    func loginManagerDidComplete(_ result: LoginResult) {
        switch result {
        case .cancelled:
            print("User cancelled login")
        case .failed(let error):
            print("Login failed with error \(error)")
        case .success(let grantedPermissions, _, _):
            print("Login succeeded with granted permissions: \(grantedPermissions)")
            getFBUserData()
            nextHomeVC()
        }
    }
    func checkValidUserName() {
        let userName: String = (self.usernameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.passwordTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
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
        //chua nhap userName
        if userName == "" {
            showError()
            return
        }
        //chua nhap password
        if password == "" {
            showError()
            return
        }
        
        if !phoneNumber.isPhoneNumber == true, !UtilityFunction.checkIsEmail(inputStr: userName) {
            showError(string: "Số điện thoại hoặc email không đúng định dạng")
            return
        }
        
        if !self.isValidPassword(testPass: password) {
            showError(string: "do dai pass k du")
            return
        }
        //check thanh cong het thi vao day
        self.nextHomeVC()
        self.showError(string: "Login sucesss for account \(userName)")
//        Auth.auth().signIn(withEmail: userName, password: password) { [weak self] user, error in
//            guard let strongSelf = self else { return }
//            if(error != nil) {
//                strongSelf.showError(string: "password hoặc email không đúng xin vui lòng nhập lại")
//                print(error)
//                return
//            }
        }
    struct Defaults {
        static let (userName, password) = ("userName", "password")
        static let userSessionKey = "com.save.usersession"
        private static let userDefault = UserDefaults.standard
        struct UserDetails {
            let name: String
            let pass: String
            
            init(_ json: [String: String]) {
                self.name = json[userName] ?? ""
                self.pass = json[password] ?? ""
            }
        }
        //Lưu chi tiết người dùng
        static func save(_ userName: String, password: String){
            userDefault.set([userName: userName, password: password],
                            forKey: userSessionKey)
        }
        //Tìm nạp các giá trị thông qua Model  UserDetails
        static func getNameAndAddress()-> UserDetails {
            return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: String]) ?? [:])
        }
        //Xoá chi tiết người dùng trong UserDefault qua key "com.save.usersession"
        static func clearUserData(){
            userDefault.removeObject(forKey: userSessionKey)
        }
    }
    // MARK: setupViewLogin
    func setupViewLogin() {
        let whiteCustomer = UIColor(red: 255, green: 255, blue: 254, alpha: 0)
        userNameView.layer.cornerRadius = 25
        userNameView.layer.masksToBounds = true
        userNameView.layer.borderWidth = 1.0
        userNameView.layer.borderColor = UIColor.white.cgColor
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "user name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordView.layer.cornerRadius = 25
        passwordView.layer.masksToBounds = true
        passwordView.layer.borderWidth = 1.0
        passwordView.layer.borderColor = UIColor.white.cgColor
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        facebookView.layer.cornerRadius = 20
        facebookView.layer.masksToBounds = true
        facebookView.layer.borderWidth = 1.0
        facebookView.layer.borderColor = UIColor.white.cgColor
        googleView.layer.cornerRadius = 20
        googleView.layer.masksToBounds = true
        googleView.layer.borderWidth = 1.0
        googleView.layer.borderColor = UIColor.white.cgColor
        btnLogin.layer.cornerRadius = 25
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.borderWidth = 1.0
        btnLogin.layer.borderColor = UIColor.white.cgColor
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^0[98375]{1}\\d{8}$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}
