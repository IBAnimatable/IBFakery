//
//  Created by Eric Marchand on 04/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import UIKit

public class IBFakery: NSObject {

    // MARK: attribute
    weak open var view: NSObject?

    var keyPaths = [String]()

    // MARK: init
    internal init(view: NSObject) {
        self.view = view
    }

    // MARK: override KVC

    open override func value(forKey key: String) -> Any? {
        self.keyPaths.append(key)
        return self
    }

    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if let viewKey = value as? String, let view = self.view {
            keyPaths.append(key)
            let key = keyPaths.joined(separator: ".")

            if key == "color" {
                let value = UIColor.random()
                view.setValue(value, forKey: viewKey)
            } else if let value = IBFaker.shared.generate(for: key) {
                view.setValue(value, forKey: viewKey)
            }
        }
    }

}

// Simple implementation of faker using Fakery framework
// as proof of concept
import Fakery
class IBFaker {

    public static var shared: IBFaker = IBFaker()

    public var locale: String {
        didSet {
            if locale != oldValue {
                parser.locale = locale
            }
        }
    }

    public let generator: Generator

    let parser: Parser

    public init(locale: String = Config.defaultLocale) {
        self.locale = locale
        parser = Parser(locale: self.locale)
        generator = Generator(parser: parser)
    }

    open func generate(for key: String) -> Any? {
        #if TARGET_INTERFACE_BUILDER
            // Fakery using this function return only String
            // Do not 'numerify' or 'letterify' formats
            // We want more type like color, primitive types
            return generator.generate(key)
        #else
            // Maybe fake only in interface builder
            // so here could add a boolean property to check
            return generator.generate(key)
        #endif
    }

}

// As proof of concept generate random color
extension UIColor {
    static func random() -> UIColor {
        let hue: CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
