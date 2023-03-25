//
//  LoadJsonError.swift
//  BurgerMe
//
//  Created by James Thang on 25/03/2023.
//

import Foundation

enum LoadJsonError: Error {
    case CannotFind
    case CannotLoad
    case CannotParse
}
