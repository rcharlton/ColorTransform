//
//  ViewController.swift
//  ColorTransform
//
//  Created by Robin Charlton on 16/02/2019.
//  Copyright © 2019 Robin Charlton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private enum Constant {
        static let transforms = [lighter, normal, darker]

        private static let normal = UIColor.Transform.identity
        private static let darker = UIColor.Transform(hue: +h, saturation: +s, brightness: -b)
        private static let lighter = UIColor.Transform(hue: -h, saturation: -s, brightness: +b)

        private static let h: CGFloat = 6       // degrees
        private static let s: CGFloat = 0.2     // scalar %
        private static let b: CGFloat = 0.3     // scalar %

        static let rowCount = 5
    }

    @IBOutlet private var stackView: UIStackView!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    private func setupSubviews() {
        let rows: [UIView] = (1...Constant.rowCount)
            .map {
                let hue = CGFloat($0) / CGFloat(Constant.rowCount)
                let color = ViewController.makeColor(hue: hue)
                return ViewController.makeSwatchRowView(color: color, transforms: Constant.transforms)
        }

        rows.forEach { stackView.addArrangedSubview($0) }
    }

    private static func makeSwatchRowView(color: UIColor, transforms: [UIColor.Transform]) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal

        let swatchViews = transforms
            .map { color.transformed(by: $0) }
            .map { SwatchView(color: $0) }

        swatchViews.forEach {
            stackView.addArrangedSubview($0)

            if $0 !== swatchViews.last {
                stackView.addArrangedSubview(ViewController.makeArrowView())
            }
        }

        return stackView
    }

    private static func makeColor(hue: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: 0.8, brightness: 0.8, alpha: 1.0)
    }

    private static func makeArrowView() -> UIView {
        let label = UILabel()
        label.text = "➡︎"
        label.textColor = UIColor(white: 0, alpha: 0.25)
        label.font = UIFont.boldSystemFont(ofSize: 48)
        return label
    }

}
