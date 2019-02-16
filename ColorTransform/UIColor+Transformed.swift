//
//  UIColor+Transformed.swift
//  UIExperiments
//
//  Created by Robin Charlton on 17/01/2018.
//  Copyright © 2018 Robin Charlton. All rights reserved.
//

import UIKit

extension UIColor {

    struct Transform {
        /// The offset applied to hue, in degrees 0...+-360.
        let hue: CGFloat

        /// The % change to the saturation.
        let saturation: CGFloat

        /// The % change to the brightness.
        let brightness: CGFloat

        /// color.transformed(by: identity) is always equal to color.
        static let identity = Transform(hue: 0, saturation: 0, brightness: 0)
    }

    /// Compute the color formed by applying the given transform to this color.
    ///
    /// - Parameter transform: Describes the changes to the color.
    /// - Returns:             The resulting colour.
    func transformed(by transform: Transform) -> UIColor {
        let hsba = UnsafeMutablePointer<CGFloat>.allocate(capacity: 4)
        hsba.initialize(repeating: 0.0, count: 4)

        getHue(&hsba[0], saturation: &hsba[1], brightness: &hsba[2], alpha: &hsba[3])

        let phase = Int(6 * hsba[0])
        let hueDirection: CGFloat = ((phase % 2) == 0) ? 1.0 : -1.0

        let hue = (hsba[0] + (hueDirection * transform.hue / 360)).clamped(min: 0, max: 1)
        let saturation = (hsba[1] + transform.saturation).clamped(min: 0, max: 1)
        let brightness = (hsba[2] + transform.brightness).clamped(min: 0, max: 1)

        let result = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: hsba[3])

        hsba.deinitialize(count: 4)
        hsba.deallocate()

        return result
    }
}

private extension CGFloat {

    func clamped(min: CGFloat, max: CGFloat) -> CGFloat {
        guard self <= max else { return max }
        guard min <= self else { return min }
        return self
    }

}
