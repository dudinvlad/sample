//
//  SoundtrackManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 11.11.2021.
//

import Foundation

struct LocalSoundtrackManager: SoundtrackStoreService {
    func saveTracks(_ items: [Soundtrackable]) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        guard let offlineMusicDirectory = documentDirectory?.appendingPathComponent("OfflineMusic", isDirectory: true) else { return }
        if !FileManager.default.fileExists(atPath: offlineMusicDirectory.path) {
            try? FileManager.default.createDirectory(at: offlineMusicDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        items.forEach { item in
            let destinationUrl = offlineMusicDirectory.appendingPathComponent(item.fileName)
            let newFileUrl = "https" + item.soundtrackPath.dropFirst(4)
            guard
                let soundUrl = URL(string: newFileUrl),
                let soundData = try? Data(contentsOf: soundUrl)
            else { return }

            do {
                try soundData.write(to: destinationUrl)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getTracks(completion: @escaping ([Soundtrackable]) -> Void) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        if let offlineMusicDirectory = documentDirectory?.appendingPathComponent("OfflineMusic", isDirectory: true) {
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory(at: offlineMusicDirectory, includingPropertiesForKeys: nil)
                print(directoryContents)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
