//
//  ChooseMusicViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        // MARK: - Dependencies

        // MARK: - Variables

        private lazy var containerStack: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack
            $0.spacing = 20
        }

        private lazy var titleLabel: UILabel = build {
            $0 <~ Style.Label.titleLabel
            $0.text = "Get into it!"
        }

        private lazy var descriptionLabel: UILabel = build {
            $0 <~ Style.Label.descriptionLabel
            $0.text = "Tap the button below to start adding your favorite music"
        }

        private lazy var spacerView: UIView = .init()

        private lazy var spotifyButton: UIButton = build {
            $0 <~ Style.Button.spotifyButton
            $0.setTitle("Add new", for: .normal)
            $0.setImage(Style.Image.plusFilled, for: .normal)
            $0.contentHorizontalAlignment = .leading
            $0.titleEdgeInsets.left = 20
            $0.imageEdgeInsets.left = 10
            $0.backgroundColor = .systemGray6
            $0.imageView?.tintColor = UIColor.systemGreen
            $0.addAction(spotifyAction, for: .touchUpInside)
        }

        private var dataSource: [SpotifyTrack] = .init()

        private lazy var trackTableView: UITableView = build {
            $0.register(ChooseSourceTableViewCell.self, forCellReuseIdentifier: String(describing: ChooseSourceTableViewCell.self))
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.isHidden = true
        }

        private lazy var spotifyAction: UIAction = .init { _ in
            self.output.showChooseSource()
        }

        var output: ViewOutput!

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            super.init(nibName: nil, bundle: nil)

        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            output.willAppear()
        }

        // MARK: - UITableViewDataSource, UITableViewDelegate

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            dataSource.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChooseSourceTableViewCell.self)) as? ChooseSourceTableViewCell {

                cell.setup(with: dataSource[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 74
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.output.saveSelectedTrack(dataSource[indexPath.row])
        }
    }
}

private extension View {
    func initialSetup() {
        view.backgroundColor = Style.Color.black
        view.addSubview(containerStack)
//        view.addSubview(trackTableView)

        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(descriptionLabel)
        containerStack.addArrangedSubview(spotifyButton)
        containerStack.addArrangedSubview(spacerView)
        containerStack.addArrangedSubview(trackTableView)

        containerStack.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }

        spotifyButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

//        trackTableView.snp.makeConstraints { make in
//            make.topMargin.equalToSuperview().offset(30)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview()
//        }

        title = "Choose Music"
    }
}

extension View: Module.ViewInput {
    func update(with tracks: [SpotifyTrack]) {
        dataSource = tracks
        trackTableView.isHidden = dataSource.isEmpty
        spacerView.isHidden = !dataSource.isEmpty
        trackTableView.reloadData()
    }
}
