//
//  SubscriptionCardCollectionViewCell.swift
//  TestSdk
//
//  Created by macuser on 11/1/21.
//

import UIKit

class SubscriptionCardCollectionViewCell: UICollectionViewCell {

    private lazy var checkImageView: UIImageView = build {
        $0.image = Style.Image.emplyCircle
    }

    private lazy var periodLabel: UILabel = build {
        $0.textColor = Style.Color.white
        $0.textAlignment = .center
        $0.textColor = Style.Color.white
    }

    private lazy var priceLabel: UILabel = build {
        $0.textColor = Style.Color.white
        $0.textAlignment = .center
        $0.textColor = Style.Color.white
        $0.font = Style.Font.priceDescriptionSmall
    }

    private lazy var perLabel: UILabel = build {
        $0.textColor = Style.Color.white
        $0.textAlignment = .center
        $0.textColor = Style.Color.white
        $0.font = Style.Font.priceDescriptionSmall
        $0.numberOfLines = 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContent(cardModel: SubscriptionCardModel) {
        periodLabel.text = cardModel.product.localizedTitle
        priceLabel.text = "\(cardModel.product.price.description) USD"
        perLabel.text = cardModel.product.localizedDescription
        configureStyle(with: cardModel.style)
    }

    func configureStyle(with style: SubscriptionCardStyle) {
        switch style {
            case .selected:
                checkImageView.image = Style.Image.check
                addBorder(color: Style.Color.lightGreen)
            case .nonSelected:
                checkImageView.image = Style.Image.emplyCircle
                addBorder(color: .clear)

        }
    }

}

private extension SubscriptionCardCollectionViewCell {
    func commonSetup() {
        cornerRadius(12)
        backgroundColor = Style.Color.backgroundGray

        addSubview(checkImageView)
        addSubview(periodLabel)
        addSubview(priceLabel)
        addSubview(perLabel)

        makeConstraints()

        isSkeletonable = true
//        checkImageView.isSkeletonable = true
//        periodLabel.isSkeletonable = true
//        priceLabel.isSkeletonable = true
//        perLabel.isSkeletonable = true
    }

    func makeConstraints() {
        checkImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(12)
        }

        periodLabel.snp.makeConstraints { make in
            make.leading.trailing.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.top.equalTo(checkImageView.snp.bottom).offset(10)
        }

        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.greaterThanOrEqualTo(self.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.top.equalTo(periodLabel.snp.bottom).offset(10)

        }

        perLabel.snp.makeConstraints { make in
            make.leading.trailing.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
        }
    }
}
