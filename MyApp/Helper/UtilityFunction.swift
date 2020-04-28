//
//  UtilityFunction.swift
//  NewProject
//
//  Created by hưng hoàng on 4/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
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
}
