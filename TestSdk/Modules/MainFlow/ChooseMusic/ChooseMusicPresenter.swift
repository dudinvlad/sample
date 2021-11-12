//
//  ChooseMusicPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseMusicModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let userDefaultsManager: UserDefaultsManager
        private let notificationManager: NotificationManager
        private let storageService: (StorageService & SoundtrackStoreService)
        private var trackDidSelectHandler: (() -> Void)?
        private let soundStoreService: SoundtrackStoreService

        required init(
            userDefaultsManager: UserDefaultsManager,
            notificationManager: NotificationManager,
            storageService: (StorageService & SoundtrackStoreService),
            trackDidSelectHandler: (() -> Void)?,
            soundStoreService: SoundtrackStoreService
        ) {
            self.userDefaultsManager = userDefaultsManager
            self.notificationManager = notificationManager
            self.storageService = storageService
            self.trackDidSelectHandler = trackDidSelectHandler
            self.soundStoreService = soundStoreService
        }

    }
}

private extension Presenter {
    func writeToDisk(_ item: Soundtrackable) {
        var soundUrlPath = item.soundtrackPath
        if let code = item.soundtrackPath.components(separatedBy: ":").first {
            if code == "http" {
                soundUrlPath = "https" + item.soundtrackPath.dropFirst(4)
            }
        }
        guard
            let previewUrl = URL(string: soundUrlPath),
            let soundData = try? Data(contentsOf: previewUrl)
        else { return }

        if let directory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
            let soundDirectory = directory.appendingPathComponent("Sounds")

            do {
                try FileManager.default.createDirectory(atPath: soundDirectory.path,
                                                withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }

            let destinationUrl = soundDirectory.appendingPathComponent("local_push.mp3")

            DispatchQueue.global(qos: .background).async {
                do {
                    try soundData.write(to: destinationUrl, options: [.atomic])
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }

    }
}

extension Presenter: Module.ViewOutput {
    func showChooseSource() {
        router.showChooseSourceModule()
    }

    func saveSelectedTrack(_ item: Soundtrackable) {
        writeToDisk(item)
        let date: Date = userDefaultsManager.get(UserDefaultsManager.Keys.selectedDate.rawValue) ?? Date()
        notificationManager.scheduleNotification(dateTime: date)
        router.dismissChooseFlow()
    }

    func requestSavedTracks() {
        storageService.getTracks { [ weak self] savedTracks in
            self?.view.update(with: savedTracks)
        }
    }

    func trackDidSelect() {
        trackDidSelectHandler?()
    }
}

extension Presenter: Module.InteractorOutput {
    func success(with tracks: [Soundtrackable]) {
        view.update(with: tracks)
    }

    func willAppear() {
        requestSavedTracks()
    }

    var controller: BaseViewInput? {
        view
    }
}
