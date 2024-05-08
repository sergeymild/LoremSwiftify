//
//  LoremKind.swift
//
//
//  Created by Enes Karaosman on 28.03.2024.
//

import Foundation

public enum LoremKind {
    case string(StringLorem)
    case url(URLLorem)
    case array(Int)
}

public extension LoremKind {
    enum StringLorem: String {
        case name
        case email
        case phoneNumber
        case creditCard
        case hexColor
        case rgbColor
        case date
        case `default`
    }
}

public extension LoremKind {
    enum URLLorem: String {
        case image
        case website
    }
}
