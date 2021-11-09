//
//  SpotifyMusicViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 07.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifyMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        // MARK: - Dependencies

        var output: ViewOutput!

        private var dataSource: [SpotifyTrack] = .init()

        private lazy var trackTableView: UITableView = build {
            $0.register(ChooseSourceTableViewCell.self, forCellReuseIdentifier: String(describing: ChooseSourceTableViewCell.self))
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init(_ inputData: SavedTracksResponseModel) {
            super.init(nibName: nil, bundle: nil)

            dataSource = inputData.items.map { $0.track }
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            trackTableView.reloadData()
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

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if dataSource.count - 1 == indexPath.row {
                self.output.requestMoreSaveTrack()
            }
        }
    }
}

private extension View {
    func initialSetup() {
        title = "Spotify"
        view.backgroundColor = Style.Color.black
        view.addSubview(trackTableView)

        trackTableView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

extension View: Module.ViewInput {
    func updateTracks(with data: [SpotifyTrack]) {
        self.dataSource += data
        trackTableView.reloadData()
    }
}
