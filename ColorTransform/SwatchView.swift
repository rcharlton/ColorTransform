//
//  SwatchView.swift
//  ColorTransform
//
//  Created by Robin Charlton on 20/01/2019.
//  Copyright © 2019 Robin Charlton. All rights reserved.
//

import UIKit

class SwatchView: UIView {

    private enum Constant {
        static let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        static let textColor = UIColor.white
        static let labelSeparation: CGFloat = 4
        static let defaultSize = CGSize(width: 100, height: 100)
    }

    var color: UIColor {
        get {
            return ellipseView.color
        }

        set {
            ellipseView.color = newValue

            let count = 3
            let hsb = UnsafeMutablePointer<CGFloat>.allocate(capacity: count)
            hsb.initialize(repeating: 0.0, count: count)
            ellipseView.color.getHue(&hsb[0], saturation: &hsb[1], brightness: &hsb[2], alpha: nil)

            labels[0].text = String(format: "H: %.f°", hsb[0] * 360)
            labels[1].text = String(format: "S: %.f%%", hsb[1] * 100)
            labels[2].text = String(format: "B: %.f%%", hsb[2] * 100)

            hsb.deinitialize(count: count)
            hsb.deallocate()
        }

    }

    private let labels: [UILabel] = {
        let makeLabel = { () -> UILabel in
            let label = UILabel()
            label.textColor = Constant.textColor
            label.font = Constant.font
            return label
        }
        return [makeLabel(), makeLabel(), makeLabel()]
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.labelSeparation
        return stackView
    }()

    private let ellipseView = EllipseView()

    convenience init(color: UIColor, size: CGSize = Constant.defaultSize) {
        self.init()

        self.color = color

        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(ellipseView)

        ellipseView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ellipseView.topAnchor.constraint(equalTo: topAnchor),
            ellipseView.leftAnchor.constraint(equalTo: leftAnchor),
            ellipseView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ellipseView.rightAnchor.constraint(equalTo: rightAnchor)])

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)])

        labels.forEach { stackView.addArrangedSubview($0) }
    }

}
