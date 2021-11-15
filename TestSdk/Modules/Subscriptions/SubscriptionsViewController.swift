//
//  SubscriptionsViewController.swift
//  TestSdk
//
//  Created macuser on 10/29/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit
import SkeletonView

private typealias Module = SubscriptionsModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            super.init(nibName: nil, bundle: nil)

        }

        // MARK: - Variables
        private let cellReuseIdentifier = String(describing: SubscriptionCardCollectionViewCell.self)

        private var dataSource: [SubscriptionCardModel] = []

        private lazy var closeButton: UIButton = build {
            $0.setImage(Style.Image.close, for: .normal)
            $0.tintColor = Style.Color.white
            $0.addAction(closeDidTap, for: .touchUpInside)
        }

        private lazy var restoreButton: UIButton = build {
            $0.setTitle("Restore", for: .normal)
            $0.tintColor = Style.Color.main
            $0.addAction(restoreDidTap, for: .touchUpInside)
        }

        private lazy var titleLabel: UILabel = build {
            $0.text = "Unlock Your Music"
            $0.textColor = Style.Color.white
            $0.font = Style.Font.titleBold
        }

        private lazy var collectionLayout: UICollectionViewFlowLayout = build {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 10
            $0.minimumLineSpacing = 10
        }

        private lazy var collectionView: UICollectionView = build(
            .init(
                frame: .zero,
                collectionViewLayout: collectionLayout
            )
        ) {
            $0.register(SubscriptionCardCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
            $0.isPagingEnabled = true
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = false
            $0.allowsMultipleSelection = false
        }

        private lazy var subscriptionButton: UIButton = build {
            $0.setTitle("Subscribe", for: .normal)
            $0.titleLabel?.font = Style.Font.titleBold
            $0.addAction(subscriptionDidTap, for: .touchUpInside)
            $0.cornerRadius(24)
        }

        private lazy var descriptionLabel: UILabel = build {
            $0.text = "* All plans include 3 Days from Trial"
            $0.textColor = Style.Color.white
            $0.textAlignment = .center
            $0.font = Style.Font.priceDescriptionSmall
        }

        private var selectedProduct: SKProduct?

        // MARK: - Actions
        private lazy var closeDidTap: UIAction = .init { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }

        private lazy var restoreDidTap: UIAction = .init { [weak self] _ in
            self?.output.restoreDidTap()
        }

        private lazy var subscriptionDidTap: UIAction = .init { [weak self] _ in
            guard let self = self, let product = self.selectedProduct else { return }

            self.output.subscriptionDidTap(product: product)
        }

        private lazy var termsDidTap: UIAction = .init { [weak self] _ in }
        private lazy var privacyPolicyDidTap: UIAction = .init { [weak self] _ in }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            commonSetup()
            makeConstraints()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            subscriptionButton.setGradientBackground(topColor: Style.Color.darkGreen, bottomColor: Style.Color.lightGreen)
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            output.didAppear()

            collectionView.isSkeletonable = true
            let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)

            collectionView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .wetAsphalt), animation: animation, transition:  .crossDissolve(0.25))
        }
    }
}

extension View: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        cellReuseIdentifier
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? SubscriptionCardCollectionViewCell else { return UICollectionViewCell() }

        cell.setupContent(cardModel: dataSource[indexPath.row])
        cell.configureStyle(with: dataSource[indexPath.row].style == .selected ? .selected : .nonSelected)

        if dataSource[indexPath.row].style == .selected {
            selectedProduct = dataSource[indexPath.row].product
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) as? SubscriptionCardCollectionViewCell {
                cell.configureStyle(with: .nonSelected)
            }
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? SubscriptionCardCollectionViewCell {
            cell.configureStyle(with: .selected)
            selectedProduct = dataSource[indexPath.row].product
        }
    }

}

private extension View {
    func commonSetup() {
        view.backgroundColor = Style.Color.main
        collectionView.delegate = self
        collectionView.dataSource = self
        self.isModalInPresentation = true
    }

    func makeConstraints() {
        view.addSubview(restoreButton)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(subscriptionButton)
        view.addSubview(descriptionLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }

        restoreButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
            make.height.equalTo(24)
            make.width.equalTo(100)
        }

        closeButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(24)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.center.equalToSuperview()
            make.height.equalTo(120)
        }

        subscriptionButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(14)
            make.leading.equalTo(collectionView)
            make.trailing.equalTo(collectionView)
            make.height.equalTo(60)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subscriptionButton.snp.bottom).offset(14)
            make.leading.trailing.greaterThanOrEqualTo(view).inset(32)
            make.centerX.equalTo(subscriptionButton.center.x)
        }
    }
}

extension View: Module.ViewInput {
    func set(dataSource value: [SubscriptionCardModel]) {
        self.dataSource = value
        self.isModalInPresentation = false
        self.collectionView.stopSkeletonAnimation()
        self.view.hideSkeleton()
        self.collectionView.reloadData()
    }

    func successPurchase() {
        dismiss(animated: true, completion: nil)
    }
}
