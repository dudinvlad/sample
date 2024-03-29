//
//  ChooseSourceTableViewCell.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 04.11.2021.
//

import UIKit
import SDWebImage

class ChooseSourceTableViewCell: UITableViewCell {
    // MARK: - Variables

    private lazy var containerStack: UIStackView = build {
        $0 <~ Style.Stack.defaultHorizontalStack
        $0.cornerRadius(5)
        $0.backgroundColor = .systemGray6
    }

    private lazy var containerLabelStack: UIStackView = build {
        $0 <~ Style.Stack.defaultVerticalStack
    }

    private lazy var iconImageView: UIImageView = build {
        $0.contentMode = .scaleAspectFill
    }

    private lazy var titleLabel: UILabel = build {
        $0 <~ Style.Label.titleLabel
    }

    private lazy var descriptionLabel: UILabel = build {
        $0 <~ Style.Label.descriptionLabel
        $0.textColor = .lightGray
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        iconImageView.image = nil
    }

    // MARK: - Public

    func setup(with item: Soundtrackable) {
        titleLabel.text = item.artistName
        descriptionLabel.text = item.soundtrackName
        iconImageView.image = item.isSpotify ? Style.Image.spotify : Style.Image.offlineMusic
    }

    // MARK: - Private

    private func commonSetup() {
        backgroundColor = .clear
        addSubview(containerStack)
        selectionStyle = .none

        containerStack.addArrangedSubview(iconImageView)
        containerStack.addArrangedSubview(containerLabelStack)

        containerLabelStack.addArrangedSubview(titleLabel)
        containerLabelStack.addArrangedSubview(descriptionLabel)

        containerStack.setCustomSpacing(20, after: iconImageView)

        containerStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 64, height: 64))
        }

    }
}
