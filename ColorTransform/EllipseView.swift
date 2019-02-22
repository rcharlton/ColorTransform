//
//  EllipseView
//  ColorTransform
//
//  Created by Robin Charlton on 08/02/2019.
//  Copyright © 2019 Robin Charlton. All rights reserved.
//

import UIKit

class EllipseView: UIView {

    private enum Constant {
        static let shadowColor = UIColor.black.withAlphaComponent(0.6)
        static let shadowOffset = CGSize(width: 0, height: 1)
        static let shadowBlurRadius: CGFloat = 2
        static let shadowInset: CGFloat = 2
        static let ellipseInset: CGFloat = 5
    }

    var color: UIColor = .cyan {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!

        let shadow = NSShadow()
        shadow.shadowColor = Constant.shadowColor
        shadow.shadowOffset = Constant.shadowOffset
        shadow.shadowBlurRadius = Constant.shadowBlurRadius

        let shadowRect = bounds.insetBy(dx: Constant.shadowInset, dy: Constant.shadowInset)
        let shadowPath = UIBezierPath(ovalIn: shadowRect)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset,
                          blur: shadow.shadowBlurRadius,
                          color: Constant.shadowColor.cgColor)
        UIColor.white.setFill()
        shadowPath.fill()
        context.restoreGState()

        let ellipseRect =  bounds.insetBy(dx: Constant.ellipseInset, dy: Constant.ellipseInset)
        let ellipsePath = UIBezierPath(ovalIn: ellipseRect)
        color.setFill()
        ellipsePath.fill()
    }

}
