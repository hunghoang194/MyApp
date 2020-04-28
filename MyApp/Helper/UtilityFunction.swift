//
//  UtilityFunction.swift
//  NewProject
//
//  Created by hưng hoàng on 4/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class UtilityFunction: NSObject {
      static func checkIsEmail(inputStr: String) -> Bool {
          if let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) {
              let matches = detector.matches(in: inputStr, options: [], range: NSMakeRange(0, inputStr.count))
              for match in matches {
                  if let matchURL = match.url,
                      let matchURLComponents = URLComponents(url: matchURL, resolvingAgainstBaseURL: false),
                      matchURLComponents.scheme == "mailto"
                  {
                      print("email: \(matchURLComponents.path)")
                      return true
                  }
              }
          }
          return false
      }
    static func isValidPhone(phoneNumber: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "+0123456789")
        if phoneNumber.rangeOfCharacter(from: characterset.inverted) == nil {
            return true
        }
        return false
    }
    static  func entityExists(userName: String) -> Bool? {
           guard let appDelegate =
             UIApplication.shared.delegate as? AppDelegate else {
             return nil
           }
           let managedContext =
             appDelegate.persistentContainer.viewContext
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersEntity")
           let predicate = NSPredicate(format: "userName == %@", userName)
           request.predicate = predicate
           request.fetchLimit = 1

           do{
               let count = try managedContext.count(for: request)
               if(count == 0){
               // no matching object
                   return false
               }
               else{
               // at least one matching object exists
                   return true
               }
             }
           catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
             }
        return nil
       }
    
    static  func checkAccountLogin(userName: String,password:String) -> Bool? {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return nil
        }
        let managedContext =
          appDelegate.persistentContainer.viewContext
       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersEntity")
        let predicate = NSPredicate(format: "userName == %@ && password == %@ ", userName,password)
        request.predicate = predicate
        request.fetchLimit = 1

        do{
            let count = try managedContext.count(for: request)
            if(count == 0){
            // no matching object
                return false
            }
            else{
            // at least one matching object exists
                return true
            }
          }
        catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
          }
     return nil
    }
}
