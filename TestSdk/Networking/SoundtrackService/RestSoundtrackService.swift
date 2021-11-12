//
//  RestSoundtrackService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 11.11.2021.
//

import Foundation

struct RestSoundtrackService: SoundtrackService {
    // MARK: - Variables

    private let apiManager: ApiManager

    // MARK: - Init
    init(
        _ apiManager: ApiManager
    ) {
        self.apiManager = apiManager
    }

    func fetchDefaultsSoundtracks(_ completion: @escaping SoundtrackResponseBlock) {
        let request = SoudntrackEndpoint.getDefaultTracks

        apiManager.request(endoint: request) { (response: SoundtrackResponse?, error) in
            completion(response?.ringtones, error)
        }
    }
}
