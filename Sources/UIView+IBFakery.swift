//
//  Created by Eric Marchand on 04/04/2017.
//  Copyright © 2017 Eric Marchand. All rights reserved.
//

import UIKit

private var xoAssociationKey: UInt8 = 0
public extension UIView {

    /// The fakery object. Will be 
    public var fakery: IBFakery! {
        get {
            var fakery = objc_getAssociatedObject(self, &xoAssociationKey) as? IBFakery
            if fakery == nil {
                fakery = IBFakery(view: self)
                self.fakery = fakery
            }
            fakery?.keyPaths.removeAll()
            return fakery
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    dynamic public var hasIBFakery: Bool {
        let bindTo = objc_getAssociatedObject(self, &xoAssociationKey) as? IBFakery
        return bindTo != nil
    }

}

extension UIView {
    // Trying to avoid app crash if bad binding
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("Trying to set value '\(String(describing: value))' on key '\(key)' on view '\(self)")
    }
    
}
