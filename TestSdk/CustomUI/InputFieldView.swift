//
//  InputFieldView.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

class InputFieldView: UIView {
    private lazy var titleLabel: UILabel = .init() <~ Style.Label.inputTitleLabel
    private lazy var inputFieldView: UIView = build {
        $0.addBorder(color: Style.Color.mainGray)
        $0.cornerRadius(4)
    }
    private lazy var fieldView: UITextField = build {
        $0.font = Style.Font.inputRegular
        $0.textColor = .black
    }
    private lazy var trailingImageView: UIImageView = .init()
    private lazy var contentStackView: UIStackView = .init() <~ Style.Stack.smallSpaceVerticalStack

    var currentText: String {
        fieldView.text ?? ""
    }

    var isSecureTextEntry: Bool = false {
        didSet {
            fieldView.isSecureTextEntry = isSecureTextEntry
        }
    }

    // MARK: Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonSetup()
    }

    private func commonSetup() {
        inputFieldView.backgroundColor = .white
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(inputFieldView)

        inputFieldView.addSubview(fieldView)
        inputFieldView.addSubview(trailingImageView)

        contentStackView.setCustomSpacing(10, after: titleLabel)

        contentStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        inputFieldView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }

        fieldView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20))
        }

        trailingImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-22)
            make.centerY.equalToSuperview()
        }
    }

    // MARK: - Public

    func set(
        title: String,
        placeholder: String = "",
        isSecureTextEntry: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        titleLabel.text = title
        fieldView.attributedPlaceholder = NSMutableAttributedString(
            string: placeholder,
            attributes: [
                .font: Style.Font.authDescriptionRegular,
                .foregroundColor: Style.Color.mainGray
            ]
        )
        fieldView.keyboardType = keyboardType
        fieldView.autocapitalizationType = .none

        self.isSecureTextEntry = isSecureTextEntry
    }
}

