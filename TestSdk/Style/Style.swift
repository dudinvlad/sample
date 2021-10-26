//
//  Style.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 22.10.2021.
//

import Foundation
import UIKit

enum Style {
    enum Image {}
    enum Color {}
    enum Font {}

    enum Label {
        struct ColoredLabel: Applicable {
            var titleColor: UIColor
            var font: UIFont
            var numberOfLines: Int = .zero
            var align: NSTextAlignment = .natural

            func apply(_ object: UILabel) {
                object.textColor = titleColor
                object.font = font
                object.numberOfLines = numberOfLines
                object.textAlignment = align
            }
        }
    }

    enum TextView {
        struct ColoredTextView: Applicable {
            var textColor: UIColor
            var font: UIFont

            func apply(_ object: UITextView) {
                object.textColor = textColor
                object.font = font
            }
        }
    }

    enum Stack {
        struct DefaulStack: Applicable {
            let spacing: CGFloat
            let axis: NSLayoutConstraint.Axis
            var alignment: UIStackView.Alignment = .fill
            var distribution: UIStackView.Distribution = .fill

            func apply(_ object: UIStackView) {
                object.spacing = spacing
                object.alignment = alignment
                object.distribution = distribution
                object.axis = axis
            }
        }

        static let defaultHorizontalStack = DefaulStack(spacing: 0, axis: .horizontal)
        static let defaultVerticalStack = DefaulStack(spacing: 0, axis: .vertical)
        static let smallSpaceVerticalStack = DefaulStack(spacing: 5, axis: .vertical)
        static let smallSpaceHorizontalStack = DefaulStack(spacing: 5, axis: .horizontal)
    }

    enum TextField {
        struct ColoredTextField: Applicable {
            let titleColor: UIColor
            let font: UIFont
            var borderColor: UIColor?

            func apply(_ object: UITextField) {
                object.borderStyle = .none
                object.textColor = titleColor
                object.font = font

                if let borderColor = self.borderColor {
                    object.layer.borderColor = borderColor.cgColor
                    object.layer.borderWidth = 1
                }
            }
        }

    }

    enum Button {
        struct ColoredButton: Applicable {
            var background: UIColor?
            var border: UIColor?
            var title: UIColor?
            var cornerRadius: CGFloat?
            let font: UIFont
            var contentEdgeInsets: UIEdgeInsets?

            init(background: UIColor? = nil, border: UIColor? = nil, title: UIColor? = nil, font: UIFont, cornerRadius: CGFloat? = nil,
                 contentEdgeInsets: UIEdgeInsets? = nil
            ) {
                self.background = background
                self.border = border
                self.title = title
                self.cornerRadius = cornerRadius
                self.font = font
                self.contentEdgeInsets = contentEdgeInsets
            }

            func apply(_ object: UIButton) {
                object.layer.masksToBounds = true

                if let background = background {
                    object.backgroundColor = background
                }

                if let border = border {
                    object.layer.borderWidth = 1
                    object.layer.borderColor = border.cgColor
                }

                if let title = title {
                    object.setTitleColor(title, for: .normal)
                    object.setTitleColor(title.withAlphaComponent(0.5), for: .disabled)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .highlighted)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .selected)
                }

                if let cornerRadius = cornerRadius {
                    object.layer.cornerRadius = cornerRadius
                }

                if let contentEdgeInsets = contentEdgeInsets {
                    object.contentEdgeInsets = contentEdgeInsets
                }

                object.titleLabel?.font = font
            }
        }
    }
}

