//
//  LoremIpsumize+Extensions.swift
//
//
//  Created by Enes Karaosman on 25.03.2024.
//

import Fakery
import Foundation
import SwiftUI

private let faker = Faker()

public protocol LoremIpsumize {
    static func lorem() -> Self

    static func lorem(_ kind: LoremKind?) -> Self
}

extension LoremIpsumize {
    public static func lorem(_ kind: LoremKind? = nil) -> Self {
        lorem(kind)
    }
}

extension Dictionary: LoremIpsumize where Key: LoremIpsumize, Value: LoremIpsumize {
    public static func lorem() -> Dictionary<Key, Value> {
        let count = Int.random(in: 2...10)

        return (0..<count).reduce(into: [:]) { result, _ in
            result[Key.lorem()] = Value.lorem()
        }
    }
}

extension Array: LoremIpsumize where Element: LoremIpsumize {
    public static func lorem() -> Array<Element> {
        let count = Int.random(in: 2...10)

        return (1...count).indices.map { _ in
            Element.lorem()
        }
    }
    
    public static func lorem(_ kind: LoremKind?) -> Array<Element> {
        switch kind {
        case .array(let count):
            if count <= 0 { return [] }
            if count == 1 { Element.lorem() }
            return (1...count).indices.map { _ in Element.lorem() }
        default:
            let count = Int.random(in: 2...10)
            return (1...count).indices.map { _ in Element.lorem() }
        }
    }
}

extension UUID: LoremIpsumize {
    public static func lorem() -> UUID {
        UUID()
    }
}

extension String: LoremIpsumize {
    public static func lorem(_ kind: LoremKind?) -> String {
        switch kind {
        case .string(.name):
            return faker.name.name()
        case .string(.email):
            return faker.internet.email()
        case .string(.phoneNumber):
            return faker.phoneNumber.phoneNumber()
        case .string(.creditCard):
            return faker.business.creditCardNumber()
        case .string(.hexColor):
            return Color.randomHexColor()
        case .string(.date):
            return ISO8601DateFormatter().string(from: Date.lorem())
        case .url(.website):
            return faker.internet.url()
        case .url(.image):
            return "https://picsum.photos/400"
        case .string(.rgbColor):
            let hexStr = String(Color.randomHexColor().dropFirst())
            var hex: UInt32 = 0
            Scanner(string: hexStr).scanHexInt32(&hex)
            return "\(Int(hex))"
        default:
            return lorem()
        }
    }

    public static func lorem() -> String {
        faker.lorem.word()
    }
}

// MARK: - Int Extensions

extension Int: LoremIpsumize {
    public static func lorem() -> Int {
        faker.number.randomInt()
    }
}

extension Int8: LoremIpsumize {
    public static func lorem() -> Int8 {
        Int8.max
    }
}

extension Int16: LoremIpsumize {
    public static func lorem() -> Int16 {
        Int16.max
    }
}

extension Int32: LoremIpsumize {
    public static func lorem() -> Int32 {
        Int32.max
    }
}

extension Int64: LoremIpsumize {
    public static func lorem() -> Int64 {
        Int64.max
    }
}

// -------------------------

// MARK: - UInt Extensions

extension UInt: LoremIpsumize {
    public static func lorem() -> UInt {
        UInt.max
    }
}

extension UInt8: LoremIpsumize {
    public static func lorem() -> UInt8 {
        UInt8.max
    }
}

extension UInt16: LoremIpsumize {
    public static func lorem() -> UInt16 {
        UInt16.max
    }
}

extension UInt32: LoremIpsumize {
    public static func lorem() -> UInt32 {
        UInt32.max
    }
}

extension UInt64: LoremIpsumize {
    public static func lorem() -> UInt64 {
        UInt64.max
    }
}

// -------------------------

extension Double: LoremIpsumize {
    public static func lorem() -> Double {
        faker.number.randomDouble()
    }
}

extension Float: LoremIpsumize {
    public static func lorem() -> Float {
        faker.number.randomFloat()
    }
}

extension Bool: LoremIpsumize {
    public static func lorem() -> Bool {
        Bool.random()
    }
}

extension Date: LoremIpsumize {
    public static func lorem() -> Date {
        if #available(iOS 15, *) {
            return Date.now
        } else {
            return Date()
        }
    }
}

extension URL: LoremIpsumize {
    public static func lorem() -> URL {
        URL(string: "https://picsum.photos/300") ?? URL(string: faker.internet.url())!
    }

    public static func lorem(_ kind: LoremKind?) -> URL {
        switch kind {
        case .url(.website):
            URL(string: faker.internet.url()) ?? lorem()
        case .url(.image):
            URL(string: "https://picsum.photos/400") ?? lorem()
        default:
            lorem()
        }
    }
}

extension Color: LoremIpsumize {
    public static func lorem() -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: 1
        )
    }

    static func randomHexColor() -> String {
        let letters = "0123456789ABCDEF"
        var colorString = "#"

        for _ in 0..<6 {
            let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
            let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            colorString.append(randomCharacter)
        }

        return colorString
    }
}
