//
//  Item.swift
//  test8
//
//  Created by Thierry hentic on 11/11/2024.
//

import SwiftUI
import AppKit
import SwiftData

@Model
class EntityModel: ObservableObject {
    // Propriétés `Data` pour stocker les couleurs
    var name: String
    @Attribute(.transformable(by: ColorTransformer.self)) var backgroundColor: NSColor
    @Attribute(.transformable(by: ColorTransformer.self)) var textColor: NSColor
    @Attribute(.transformable(by: ColorTransformer.self)) var borderColor: NSColor
    
    // Initialisateur avec des couleurs par défaut
    init() {
        self.name = "exemple1"
        // Définit des couleurs par défaut au départ
        self.backgroundColor = NSColor.green
        self.textColor = NSColor.blue
        self.borderColor = NSColor.red
    }
}

class ColorTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? NSColor else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: data)
            return color
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSColor.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    static func register() {
        ValueTransformer.setValueTransformer(ColorTransformer(), forName: .init("ColorTransformer"))
    }
}

// Extension pour convertir SwiftUI Color en NSColor
extension NSColor {
    static func fromSwiftUIColor(_ color: Color) -> NSColor {
        if let cgColor = color.cgColor {
            return NSColor(cgColor: cgColor) ?? NSColor.black
        } else {
            return NSColor.black
        }
    }
}
