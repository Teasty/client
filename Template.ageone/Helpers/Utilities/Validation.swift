//
//  Validation.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 03/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension Utiles {
    
    public struct Formatter {
        
        public func cleanPhonw(_ phone: String) -> String {
            return phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        }
        
        public func phone(_ number: String) -> String {
            var cleanPhoneNumber = cleanPhonw(number)
            //        check first
            if cleanPhoneNumber.count == 1 {
                switch cleanPhoneNumber {
                case "9": cleanPhoneNumber = "79"
                case "8": cleanPhoneNumber = "7"
                case "7": cleanPhoneNumber = "7"
                default: cleanPhoneNumber = ""
                }
            }
            //        check second
            if cleanPhoneNumber.count == 2 {
                if cleanPhoneNumber != "79" {
                    cleanPhoneNumber = "79"
                }
            }
            //        mask
            let mask = "+X (XXX) XXX-XX-XX"
            //        formatter
            var result = ""
            var index = cleanPhoneNumber.startIndex
            for subMask in mask {
                if index == cleanPhoneNumber.endIndex {
                    break
                }
                if subMask == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(subMask)
                }
            }
            return result
        }
        
        func card(_ card: String) -> String {
            let characters = card.map { String($0) }
            return ["**** \(characters[12])\(characters[13])\(characters[14])\(characters[15])"].joined(separator: "")
        }
        
    }
    
    public struct Validation {
        
        public func phone(_ text: String) -> Bool {
            let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if cleanPhoneNumber.count == 11 {
                return true
            }
            return false
        }
        
        func email(_ email: String) -> Bool {
            let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
                "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
        
    }
    
}
